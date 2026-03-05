import { HttpService } from '@nestjs/axios';
import { Controller, Post, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';

import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentService } from '../../payment/payment.service';

import { createVerify } from 'crypto';
import { BinancePayService } from './binance-pay.service';
import { PaymentStatus } from '../../database/payment.entity';
import { firstValueFrom } from 'rxjs';

@Controller('binance')
export class BinancePayController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private httpService: HttpService,
    private binancePayService: BinancePayService,
  ) {}

  @Post('callback')
  async callback(
    @Req()
    req: Request<{
      Headers: {
        'BinancePay-Timestamp': string;
        'BinancePay-Nonce': string;
        'BinancePay-Certificate-SN': string;
        'BinancePay-Signature': string;
      };
      Body: {
        bizType: string;
        bizId: string;
        bizIdStr: string;
        bizStatus: 'PAY_SUCCESS' | 'PAY_CLOSED';
        data: string;
      };
    }>,
    @Res() res: Response,
  ) {
    console.log(JSON.stringify(req.body), 'req.body');
    const orderData: BinancePayWebhookData = JSON.parse(req.body.data);
    let payment = await this.paymentService.getOne(orderData.merchantTradeNo);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    console.log('Verifying Signature...');
    const dataModified = { ...req.body, bizId: req.body.bizIdStr };
    const payload = `${req.headers['binancepay-timestamp']}\n${
      req.headers['binancepay-nonce']
    }\n${JSON.stringify(dataModified).replace(
      /"bizId":"(\d+)"/g,
      '"bizId":$1',
    )}\n`;
    const certificateResult =
      await this.binancePayService.getPublicKey(gateway);
    const publicKey = certificateResult.data[0].certPublic;
    const decodedSignature = Buffer.from(
      req.headers['binancepay-signature'],
      'base64',
    );
    const verify = createVerify('SHA256');
    verify.write(payload);
    verify.end();

    const verifyResult = verify.verify(publicKey, decodedSignature);
    if (verifyResult == false) {
      throw new Error('Signature verification failed');
    }
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      req.body.bizStatus == 'PAY_SUCCESS'
        ? PaymentStatus.Success
        : PaymentStatus.Failed,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    await firstValueFrom(
      this.httpService.get(`${payment.returnUrl}?token=${encrypted}`),
    );
    return {
      status: 'SUCCESS',
    };
  }
}

interface BinancePayWebhookData {
  merchantTradeNo: string;
}
