import { HttpService } from '@nestjs/axios';
import {
  Controller,
  ForbiddenException,
  Get,
  Query,
  Req,
  Res,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';
import * as crypto from 'crypto';

import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

import { PayFortDTO } from './paygate.service';

@Controller('paygate')
export class PayGateController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
  ) {}

  @Get('redirect')
  async redirect(
    @Query()
    query: { transactionId: string; token: string },
    @Res() res: Response,
  ) {
    const payment = await this.paymentService.getOne(query.transactionId);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const token = query.token as string;
    const base64Decoded = Buffer.from(token, 'base64').toString('utf8');
    const data: PayFortDTO = JSON.parse(base64Decoded);
    const redirectionUrl =
      process.env.DEMO_MODE != null || process.env.NODE_ENV == 'dev'
        ? 'https://sbcheckout.payfort.com/FortAPI/paymentPage'
        : 'https://checkout.payfort.com/FortAPI/paymentPage';

    const obj = {
      access_code: gateway.privateKey!,
      amount: parseInt((data.amount * 100).toString()).toString(),
      command: 'PURCHASE',
      currency: data.currency,
      customer_email: `${data.userType}_${data.userId}@user.com`,
      language: 'en',
      merchant_identifier: gateway.merchantId!,
      merchant_reference: data.transactionId,
      order_description: 'topup',
      return_url: `${process.env.GATEWAY_SERVER_URL}/amazon/callback`,
    };
    let content = `<html xmlns="https://www.w3.org/1999/xhtml"><head></head><body><form action='%redirection_url%' method='post' name='frm'><input type='hidden' name="command" value="PURCHASE"><input type='hidden' name="access_code" value="%access_code%"><input type='hidden' name="merchant_identifier" value="%merchant_identifier%"><input type='hidden' name="merchant_reference" value="%merchant_reference%"><input type='hidden' name="amount" value="%amount%"><input type='hidden' name="currency" value="%currency%"><input type='hidden' name="language" value="%language%"><input type='hidden' name="customer_email" value="%customer_email%"><input type="hidden" name="return_url" value="%return_url%"><input type='hidden' name="signature" value="%signature%"><input type='hidden' name="order_description" value="%order_description%"><script type='text/javascript'>document.frm.submit(); </script></form></body></html>`;
    Object.entries(obj).forEach(
      ([key, value], index) => (content = content.replace(`%${key}%`, value!)),
    );
    const str = `${gateway.saltKey}${Object.entries(obj)
      .map(([key, value]) => {
        return `${key}=${value}`;
      })
      .join('')}${gateway.saltKey}`;
    const signature = crypto.createHash('sha256').update(str).digest('hex');
    content = content.replace('%signature%', signature);
    content = content.replace('%redirection_url%', redirectionUrl);
    res.send(content);
  }

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { reference: string };
      Body: { response_message: string; merchant_reference: string };
    }>,
    @Res() res: Response,
  ) {
    let payment = await this.paymentService.getOne(req.body.merchant_reference);
    //TODO: Check for payment validity
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      req.body.response_message == 'Success'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}
