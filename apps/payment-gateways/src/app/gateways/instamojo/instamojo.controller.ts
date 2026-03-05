import { Controller, ForbiddenException, Get, Req, Res } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TransactionStatus } from '@ridy/database';
import { Response, Request } from 'express';
import { Repository } from 'typeorm';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentStatus } from '../../database/payment.entity';
import { PaymentService } from '../../payment/payment.service';
import { InstaMojoService } from './instamojo.service';

@Controller('instamojo')
export class InstaMojoController {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    private paymentService: PaymentService,
    private instamojoService: InstaMojoService,
  ) {}

  @Get('redirect')
  async redirect(
    @Req()
    req: Request<{ Querystring: { token: string; gatewayId: string } }>,
    @Res() res: Response,
  ) {
    // const gateway = await this.gatewayRepository.findOne(req.query.gatewayId);
    // const content = `<script src="https://sdk.mercadopago.com/js/v2"></script><div class="cho-container"></div><script>const mp=new MercadoPago('${gateway.publicKey}',{locale: 'es-AR'}); mp.checkout({preference:{id: '${req.query.token}'}, render:{container: '.cho-container',}});</script>`;
    // console.log(content);
    // res.raw.write(content);
    // res.raw.end();
  }

  @Get('callback')
  async callback(
    @Req()
    req: Request<{
      Querystring: { gatewayId: string; preference_id: string };
      Body: { posted_data: string };
    }>,
    @Res() res: Response,
  ) {
    const gateway = await this.gatewayRepository.findOneBy({
      id: parseInt(req.query.gatewayId),
    });
    // mercadopago.configure({
    //     access_token: gateway.privateKey
    // });
    // const verifyResult: MercadopagoVerifyResult = await mercadopago.preferences.get(req.query.preference_id);

    // let payment = await this.paymentService.getOne(verifyResult.external_reference);
    // if (payment == null) {
    //     throw new ForbiddenException('Transaction Not found.');
    // }
    // await this.paymentService.updatePaymentStatus(payment.id, verifyResult.response.total_amount != null ? PaymentStatus.Success : PaymentStatus.Canceled);
    // payment = await this.paymentService.getOne(verifyResult.external_reference);
    // const encrypted = await this.paymentService.getEncryptedWithPayment(payment);
    // res.redirect(301, `${payment.returnUrl}?token=${encrypted}`);
  }
}

export interface MercadopagoVerifyResult {
  external_reference: string;
  body: MercadopagoVerifyObject;
  response: MercadopagoVerifyObject;
}

export interface MercadopagoVerifyObject {
  back_urls: object;
  client_id: number;
  collector_id: number;
  date_created: string;
  id: string;
  init_point: string;
  items: [
    {
      id: string;
      currency_id: string;
      title: string;
      picture_url: string;
      description: string;
      quantity: number;
      unit_price: number;
    },
  ];
  marketplace: string;
  marketplace_fee: number;
  statement_descriptor: string;
  total_amount: number | null;
  payer: {
    phone: {
      number: string;
    };
    address: {
      zip_code: number;
      street_name: string;
      street_number: number;
    };
    identification: {
      number: number;
      type: string;
    };
  };
}
