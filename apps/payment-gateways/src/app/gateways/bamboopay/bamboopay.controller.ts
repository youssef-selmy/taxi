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
import { firstValueFrom } from 'rxjs';
import { HttpService } from '@nestjs/axios';

@Controller('bamboopay')
export class BambooPayController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private httpService: HttpService,
  ) {}

  @Get('callback')
  async callback(@Query() query: { tx_ref: string }, @Res() res: Response) {
    console.log(`Verify Bamboopay called with query: ${JSON.stringify(query)}`);
    const reference = query.tx_ref;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }

    payment = await this.paymentService.getOne(reference);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }

  @Get('status')
  async status(@Query() query: { tx_ref: string }, @Res() res: Response) {
    console.log(`Verify Bamboopay called with query: ${JSON.stringify(query)}`);
    const reference = query.tx_ref;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const gateway = await this.gatewayRepository.findOneBy({
      id: payment.gatewayId,
    });

    const basicAuth = Buffer.from(
      `${gateway.publicKey}:${gateway.privateKey}`,
    ).toString('base64');

    try {
      const result = await firstValueFrom(
        this.httpService.post<{
          billing_status: 'completed' | 'failed';
        }>(
          `https://devfront-bamboopay.ventis.group/api/check-status/${payment.externalReferenceNumber}`,
          {},
          {
            headers: {
              Authorization: `Basic ${basicAuth}`,
              'Content-Type': 'application/json',
            },
          },
        ),
      );

      await this.paymentService.updatePaymentStatus(
        payment.id,
        result.data.billing_status === 'completed'
          ? PaymentStatus.Success
          : PaymentStatus.Canceled,
      );
      payment = await this.paymentService.getOne(reference);
      const encrypted =
        await this.paymentService.getEncryptedWithPayment(payment);
      this.httpService.get(`$${payment.returnUrl}?token=${encrypted}`);
    } catch (e) {
      console.error('BambooPay error', e?.response?.data || e.message);
      throw e;
    }
  }
}
