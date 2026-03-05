import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { Agent } from 'https';

@Injectable()
export class OpenPixService {
  constructor(private httpService: HttpService) {}

  async getPaymentLink(input: {
    gateway: PaymentGatewayEntity;
    userType: string;
    userId: string;
    currency: string;
    amount: string;
  }): Promise<PaymentLinkResult> {
    const transactionId = `${input.userType}_${
      input.userId
    }_${new Date().getTime()}`;
    // const callbackUrl = `${process.env.GATEWAY_SERVER_URL}/openpix/callback`;
    // We don't need to define callbacks here, because we already defined it in the gateway server.
    // console.log('callbackUrl', callbackUrl);
    // const webhooks = await firstValueFrom(
    //   this.httpService.get<OpenPixWebhookListResponse>(
    //     'https://api.openpix.com.br/api/v1/webhook',
    //     {
    //       params: {
    //         url: callbackUrl,
    //       },
    //       headers: {
    //         Authorization: input.gateway.privateKey,
    //       },
    //     },
    //   ),
    // );
    // console.log('webhooks', JSON.stringify(webhooks.data.webhooks));
    // if (webhooks.data.webhooks.length < 1) {
    //   const creationResult = await firstValueFrom(
    //     this.httpService.post(
    //       'https://api.openpix.com.br/api/v1/webhook',
    //       {
    //         name: 'callback_url',
    //         event: 'OPENPIX:CHARGE_COMPLETED',
    //         url: callbackUrl,
    //         authorization: input.gateway.privateKey,
    //       },
    //       {
    //         headers: {
    //           Authorization: input.gateway.privateKey,
    //         },
    //       },
    //     ),
    //   );
    //   console.log('creationResult', JSON.stringify(creationResult.data));
    // }
    const result = await firstValueFrom(
      this.httpService.post<OpenPixResponse>(
        'https://api.openpix.com.br/api/v1/charge?return_existing=true',
        {
          correlationID: transactionId,
          value: parseFloat(input.amount) * 100,
        },
        {
          headers: {
            'Content-Type': 'application/json',
            Authorization: input.gateway.privateKey,
            httpsAgent: new Agent({
              rejectUnauthorized: false,
            }) as any,
          },
        },
      ),
    );
    console.log('result', JSON.stringify(result.data), 'OpenPixService');
    return {
      url: result.data.charge.paymentLinkUrl,
      invoiceId: transactionId,
    };
  }
}

interface OpenPixResponse {
  charge: {
    paymentLinkUrl: string;
  };
}

interface OpenPixWebhookListResponse {
  pageInfo: {
    skip: number;
    totalCount: number;
  };
  webhooks: {
    url: string;
  }[];
}
interface OpenPixWebhookCreateResponse {
  webhook: {
    isActive: boolean;
  };
}
