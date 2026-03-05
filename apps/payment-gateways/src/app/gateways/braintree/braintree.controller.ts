import { HttpService } from '@nestjs/axios';
import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import * as crypto from 'crypto';

import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

@Controller('braintree')
export class BraintreeController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('redirect')
  async redirect(
    @Req()
    req: Request<{
      Querystring: { transactionId: string; token: string };
    }>,
    @Res() res: Response,
  ) {
    const payment = await this.paymentService.getOne(req.query.transactionId);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
  }

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { reference: string };
      Body: { response_message: string; merchant_reference: string };
    }>,
    @Res() res: Response,
  ) {
    let payment = await this.paymentService.getOne(req.body.merchant_reference);
    //TODO: Check for payment validity
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      req.body.response_message == 'Success'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
