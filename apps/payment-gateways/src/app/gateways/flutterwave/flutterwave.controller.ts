import {
  Controller,
  ForbiddenException,
  Get,
  Query,
  Res,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response } from 'express';
import { Repository } from 'typeorm';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

@Controller('flutterwave')
export class FlutterwaveController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('callback')
  async callback(
    @Query() query: { tx_ref: string; status: string },
    @Res() res: Response,
  ) {
    console.log(
      `Verify Flutterwave called with query: ${JSON.stringify(query)}`,
    );
    const reference = query.tx_ref;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    await this.gatewayRepository.findOneBy({
      id: payment.gatewayId,
    });
    await this.paymentService.updatePaymentStatus(
      payment.id,
      query.status == 'successful'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    payment = await this.paymentService.getOne(reference);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
