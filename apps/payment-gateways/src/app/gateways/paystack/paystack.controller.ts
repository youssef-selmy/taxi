import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

import { PaystackService } from './paystack.service';

@Controller('paystack')
export class PaystackController {
  constructor(
    private paystackService: PaystackService,
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('callback')
  async callback(
    @Req() req: Request<{ Querystring: { reference: string } }>,
    @Res() res: Response,
  ) {
    console.log(
      `Verify Paystack called with query: ${JSON.stringify(req.query)}`,
    );
    const reference = req.query.reference;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const verifyResponse = await this.paystackService.verify(
      paymentMethod,
      payment.transactionNumber,
    );
    await this.paymentService.updatePaymentStatus(
      payment.id,
      verifyResponse.status ? PaymentStatus.Success : PaymentStatus.Canceled,
    );
    payment = await this.paymentService.getOne(reference);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
