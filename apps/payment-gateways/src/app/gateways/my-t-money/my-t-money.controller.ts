import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import { Repository } from 'typeorm';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';
import { MyTMoneyDTO } from './my-t-money.service';
import * as crypto from 'crypto';

const NodeRSA = require('node-rsa');

@Controller('mytmoney')
export class MyTMoneyController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('redirect')
  async redirect(
    @Req() req: Request<{ Querystring: { token: string } }>,
    @Res() res: Response,
  ) {
    const token = req.query.token;
    const base64Decoded = Buffer.from(token, 'base64').toString('utf8');
    const data: MyTMoneyDTO = JSON.parse(base64Decoded);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: data.gatewayId,
    });
    const payload_obj = {
      totalPrice: parseInt(data.amount.toString().split('.')[0]),
      currency: data.currency,
      merTradeNo: data.transactionId,
      notifyUrl: `${process.env.GATEWAY_SERVER_URL}mytmoney/callback`,
      returnUrl: '',
      lang: 'en',
      remark: 'Payment in my.t money',
    };
    const ekey = new NodeRSA(
      '-----BEGIN PUBLIC KEY-----\n' +
        gateway.publicKey +
        '-----END PUBLIC KEY-----',
    );
    const encryptedPayload = ekey.encrypt(payload_obj, 'base64');
    const signatureData = `appId=${gateway.merchantId}&merTradeNo=${data.transactionId}&payload=${encryptedPayload}&paymentType=S`;
    const hmac = crypto.createHmac('sha512', gateway.privateKey!);
    const sign = hmac.update(signatureData).digest('base64');
    const inputForm: MyTMoneyFormInput = {
      appid: gateway.merchantId!,
      merTradeNo: data.transactionId,
      payload: encryptedPayload,
      sign,
    };
    let content = `<html xmlns="https://www.w3.org/1999/xhtml"><head></head><body><form action="https://pay.mytmoney.mu/Mt/web/payments" method="post" name="frm"> <input type="hidden" name="appId" value="$appid" /> <input type="hidden" name="merTradeNo" value="$merTradeNo" /> <input type="hidden" name="payload" value="$payload" /> <input type="hidden" name="paymentType" value="S" /> <input type="hidden" name="sign" value="$sign" /></form> <script type='text/javascript'>document.frm.submit();</script></body></html>`;
    Object.entries(inputForm).forEach(
      ([key, value], index) => (content = content.replace(`$${key}`, value)),
    );
    res.raw.write(content);
    res.raw.end();
  }

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: {
        merTradeNo: string;
        tradeStatus: 'TRADE_FINISHED' | 'TRADE_CLOSED';
      };
    }>,
    @Res() res: Response,
  ) {
    console.log(
      `MYTMoney Notify is called with body: ${JSON.stringify(
        req.body,
      )} & query: ${JSON.stringify(req.query)}`,
    );
    let payment = await this.paymentService.getOne(req.query.merTradeNo);
    if (payment == null) {
      throw new ForbiddenException('Transaction Not found.');
    }
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      req.query.tradeStatus == 'TRADE_FINISHED'
        ? PaymentStatus.Success
        : PaymentStatus.Failed,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}

interface MyTMoneyFormInput {
  appid: string;
  merTradeNo: string;
  payload: string;
  sign: string;
}

interface MyTMoneyNotifyObject {
  sign: string;
  merTradeNo: string;
  tradeStatus: 'TRADE_CLOSED' | 'TRADE_FINISHED';
  tradeNo: string;
  errorCode: string;
  totalPrice: string;
  currency: string;
}
