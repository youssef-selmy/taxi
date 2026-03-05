import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import { Repository } from 'typeorm';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';
import Acquiring from 'sberbank-acquiring';

@Controller('sberbank')
export class SberBankController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { orderNumber: string; status: string };
    }>,
    @Res() res: Response,
  ) {
    console.log(
      `Verify SberBank called with query: ${JSON.stringify(req.query)}`,
    );
    const reference = req.query.orderNumber;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneBy({
      id: payment.gatewayId,
    });
    if (paymentMethod == null) {
      throw new ForbiddenException('Payment method not found.');
    }
    const acquiring = new Acquiring(
      {
        userName: paymentMethod.publicKey!,
        password: paymentMethod.privateKey!,
      },
      `${process.env.GATEWAY_SERVER_URL}/sberbank/callback`,
      process.env.DEMO_MODE != null,
    );
    const order = await acquiring.status(reference);
    console.log(`SberBank order status: ${JSON.stringify(order)}`);
    await this.paymentService.updatePaymentStatus(
      payment.id,
      req.query.status == 'successful'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    payment = await this.paymentService.getOne(reference);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('cancel')
  async cancel(
    @Req() req: Request<{ Querystring: { tx_ref: string } }>,
    @Res() res: Response,
  ) {}
}
