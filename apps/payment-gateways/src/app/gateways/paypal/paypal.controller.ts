import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { Request, Response } from 'express';
import { PaypalService } from './paypal.service';
import { InjectRepository } from '@nestjs/typeorm';

import { Repository } from 'typeorm';
import { PaymentService } from '../../payment/payment.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';

@Controller('paypal')
export class PaypalController {
  constructor(
    private payPalService: PaypalService,
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('verify')
  async verifyPayPal(
    @Req() req: Request<{ Querystring: { token: string } }>,
    @Res() res: Response,
  ) {
    let payment = await this.paymentService.getOne(req.query.token);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    this.payPalService.verify(paymentMethod, payment.transactionNumber);
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      PaymentStatus.Success,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('cancel')
  async cancelPayPal(
    @Req() req: Request<{ Querystring: { token: string } }>,
    @Res() res: Response,
  ) {
    const payment = await this.paymentService.getOne(req.query.token);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    await this.paymentService.updatePaymentStatus(
      payment.id,
      PaymentStatus.Canceled,
    );
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
