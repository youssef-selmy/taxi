import { HttpService } from '@nestjs/axios';
import {
  Controller,
  ForbiddenException,
  Get,
  Query,
  Res,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response } from 'express';
import { firstValueFrom } from 'rxjs';
import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

import { PayTMService } from './paytm.service';

@Controller('paytm')
export class PayTMController {
  constructor(
    private payTMService: PayTMService,
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private httpService: HttpService,
  ) {}

  @Get('redirect')
  async redirect(
    @Query()
    query: {
      transactionId: string;
      token: string;
    },
    @Res() res: Response,
  ) {
    const payment = await this.paymentService.getOne(query.transactionId);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const url = `${
      process.env.DEMO_MODE == null
        ? 'https://securegw.paytm.in'
        : 'https://securegw-stage.paytm.in'
    }/theia/api/v1/processTransaction?mid=${gateway.merchantId}&orderId=${
      query.transactionId
    }`;
    await firstValueFrom(
      this.httpService.post(
        url,
        {
          requestType: 'NATIVE',
          mid: gateway.merchantId,
          orderId: query.transactionId,
        },
        {
          headers: {
            'Content-Type': 'application/json',
            txnToken: query.token,
          },
        },
      ),
    );
    const inputForm: PayTMFormInput = {
      merchantId: gateway.merchantId!,
      orderId: query.transactionId,
    };
    let content = `<html xmlns="https://www.w3.org/1999/xhtml"><head></head><body><form action="${url}" headers="" method="post" name="frm"> <input type="hidden" name="requestType" value="NATIVE" /> <input type="hidden" name="mid" value="$merchantId" /> <input type="hidden" name="orderId" value="$orderId" /></form> <script type='text/javascript'>document.frm.submit();</script></body></html>`;
    Object.entries(inputForm).forEach(
      ([key, value], index) => (content = content.replace(`$${key}`, value)),
    );
    res.send(content);
  }

  @Get('callback')
  async callback(@Query() query: { reference: string }, @Res() res: Response) {
    console.log(`Verify Paystack called with query: ${JSON.stringify(query)}`);
    const reference = query.reference;
    let payment = await this.paymentService.getOne(reference);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    const paymentMethod = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const verifyResponse = await this.payTMService.verify(
      paymentMethod,
      payment.transactionNumber,
    );
    //TODO: Check for payment validity
    await this.paymentService.updatePaymentStatus(
      payment.id,
      verifyResponse ? PaymentStatus.Success : PaymentStatus.Canceled,
    );
    payment = await this.paymentService.getOne(reference);
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}

interface PayTMFormInput {
  merchantId: string;
  orderId: string;
}
