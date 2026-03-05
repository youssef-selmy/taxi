import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { Request, Response } from 'express';
import { RazorPayService } from './razorpay.service';
import { InjectRepository } from '@nestjs/typeorm';

import { Repository } from 'typeorm';
import { PaymentService } from '../../payment/payment.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';

@Controller('razorpay')
export class RazorPayController {
  constructor(
    private razorpayService: RazorPayService,
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('callback')
  async verify(
    @Req()
    req: Request<{
      Querystring: {
        razorpay_payment_id: string;
        razorpay_payment_link_reference_id: string;
        razorpay_signature: string;
      };
    }>,
    @Res() res: Response,
  ) {
    const payment = await this.paymentService.getOne(
      req.query.razorpay_payment_link_reference_id,
    );
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    await this.paymentService.updatePaymentStatus(
      payment.id,
      PaymentStatus.Success,
    );
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
