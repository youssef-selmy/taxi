import { Injectable } from '@nestjs/common';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { GetPaymentLinkBody, IntentResult } from '@ridy/database';
import { HttpService } from '@nestjs/axios';
import { createHmac } from 'crypto';
import { firstValueFrom } from 'rxjs';
import { PaymentLinkResult } from '../paypal/paypal.service';

@Injectable()
export class PayTRService {
  constructor(private httpService: HttpService) {}

  async getPaymentLink(input: {
    gateway: PaymentGatewayEntity;
    amount: string;
    currency: string;
    userId: string;
    userType: string;
  }): Promise<PaymentLinkResult> {
    const merchant_id = input.gateway.merchantId;
    const merchant_key = input.gateway.privateKey;
    const merchant_salt = input.gateway.saltKey;
    const name = 'Top-up wallet';
    const price = input.amount;
    const max_installment = '2';
    const currency = input.currency;
    const link_type = 'collection';
    const lang = 'en';
    const required =
      name +
      price +
      currency +
      max_installment +
      link_type +
      lang +
      merchant_salt +
      merchant_key;

    // const callback_link = `${process.env.GATEWAY_SERVER_URL}/paytr/callback`;
    const callback_link = 'https://www.ridy.io/callback';

    const callback_id = `${input.userType}_${
      input.userId
    }_${new Date().getTime()}`;

    const debug_on = '1';

    const paytr_token = createHmac('sha256', merchant_key)
      .update(required)
      .digest('base64');
    const data = {
      merchant_id: merchant_id!,
      name: name,
      price: price,
      currency: currency,
      link_type: link_type,
      lang: lang,
      email: `${callback_id}@user.com`,
      callback_link: callback_link,
      max_installment: max_installment,
      callback_id: callback_id,
      debug_on: debug_on,
      paytr_token: paytr_token,
    };
    console.log(JSON.stringify(data));

    const response = await firstValueFrom(
      this.httpService.post<PayTRCreatePaymentLinkResponse>(
        'https://www.paytr.com/odeme/api/link/create',
        data,
        {
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        },
      ),
    );
    console.log(JSON.stringify(response.data));

    return {
      invoiceId: callback_id,
      url: response.data.url!,
    };
  }
}

export interface PayTRCreatePaymentLinkResponse {
  status: 'success' | 'error';
  reason?: string;
  url?: string;
}
