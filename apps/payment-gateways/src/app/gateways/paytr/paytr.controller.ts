import { Controller, Get, Post, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { createHmac } from 'crypto';
import { Response, Request } from 'express';
import { Repository } from 'typeorm';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Controller('paytr')
export class PayTRController {
  constructor(
    @InjectRepository(PaymentEntity)
    private paymentRepository: Repository<PaymentEntity>,
    @InjectRepository(PaymentGatewayEntity)
    private paymentGatewayRepository: Repository<PaymentGatewayEntity>,
  ) {}

  @Post('callback')
  async callback(
    @Req()
    req: Request<{
      Body: {
        id: string;
        merchant_oid: string;
        status: string;
        total_amount: string;
        hash: string;
      };
    }>,
    @Res() res: Response,
  ) {
    const callback = req.body;
    const transactionNumber = callback.id;
    const payment = await this.paymentRepository.findOneOrFail({
      where: { transactionNumber: transactionNumber },
    });
    const gateway = await this.paymentGatewayRepository.findOneOrFail({
      where: { id: payment.gatewayId },
    });
    const token =
      callback.id +
      callback.merchant_oid +
      gateway.saltKey +
      callback.status +
      callback.total_amount;
    const paytr_token = createHmac('sha256', gateway.privateKey)
      .update(token)
      .digest('base64');

    if (paytr_token != callback.hash) {
      throw new Error('PAYTR notification failed: bad hash');
    }

    if (callback.status == 'success') {
    } else {
    }

    res.send('OK');
  }
}
