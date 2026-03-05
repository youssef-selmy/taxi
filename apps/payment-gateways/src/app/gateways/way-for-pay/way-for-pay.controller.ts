import { HttpService } from '@nestjs/axios';
import { Controller, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Response, Request } from 'express';

import { Repository } from 'typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';

import { WFP } from 'overshom-wayforpay';
import { firstValueFrom } from 'rxjs';

@Controller('wayforpay')
export class WayForPayController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private httpService: HttpService,
  ) {}

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { reference: string };
      Body: { orderReference: string };
    }>,
    @Res() res: Response,
  ) {
    console.log(
      `Notify wayforpay called with body: ${JSON.stringify(
        req.body,
      )} & query: ${JSON.stringify(req.query)}`,
    );
    let payment = await this.paymentService.getOne(req.body.orderReference);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    const wfp = new WFP({
      MERCHANT_ACCOUNT: gateway.merchantId!,
      MERCHANT_SECRET_KEY: gateway.privateKey!,
      MERCHANT_DOMAIN_NAME: gateway.publicKey!,
      SERVICE_URL: `${process.env.GATEWAY_SERVER_URL}/wayforpay/callback`,
    });
    // if webhook payload corrupted / signature invalid next line will throw an error
    const data = wfp.parseAndVerifyIncomingWebhook(req.body);
    // create special-format response for WFP server so it stops sending this webhook.
    const answer = wfp.prepareSignedWebhookResponse(data);
    payment = await this.paymentService.updatePaymentStatus(
      payment.id,
      data.transactionStatus === 'Approved'
        ? PaymentStatus.Success
        : PaymentStatus.Canceled,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    await firstValueFrom(
      this.httpService.get(`${payment.returnUrl}?token=${encrypted}`),
    );
    res.send(answer);
  }
}
