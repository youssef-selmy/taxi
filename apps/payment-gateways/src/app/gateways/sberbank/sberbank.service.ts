import { GatewayTimeoutException, Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { HttpService } from '@nestjs/axios';
import Acquiring = require('sberbank-acquiring');
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { firstValueFrom } from 'rxjs';

@Injectable()
export class SberBankService {
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
    const callbackUrl = `${process.env.GATEWAY_SERVER_URL}/sberbank/callback`;
    console.log(
      `Getting sberbank url with username: ${input.gateway.publicKey} and password ${input.gateway.privateKey}`,
    );
    const remoteUrl =
      process.env.DEMO_MODE == null
        ? 'https://3dsec.sberbank.ru/payment/rest/register.do'
        : 'https://securepayments.sberbank.ru/payment/rest/register.do';
    console.log(`Remote url: ${remoteUrl}`);
    try {
      const result = await firstValueFrom(
        this.httpService.get(remoteUrl, {
          params: {
            userName: input.gateway.publicKey!,
            password: input.gateway.privateKey!,
            amount: input.amount,
            orderNumber: transactionId,
            returnUrl: callbackUrl,
            failUrl: callbackUrl,
            description: `Пополнение баланса на ${input.amount} ${input.currency}`,
            currency: input.currency,
          },
        }),
      );
      console.log(`SberBank order: ${JSON.stringify(result.data)}`);
      return {
        invoiceId: transactionId,
        url: result.data.formUrl,
      };
    } catch (e) {
      console.log(e);
      throw new GatewayTimeoutException('Sberbank gateway is not available');
    }
    // const acquiring = new Acquiring(
    //   {
    //     userName: input.gateway.publicKey!,
    //     password: input.gateway.privateKey!,
    //   },
    //   callbackUrl,
    //   true
    // );
    // const order = await acquiring.register(
    //   transactionId,
    //   parseFloat(input.amount),
    //   transactionId,
    //   {
    //     returnUrl: `${process.env.GATEWAY_SERVER_URL}/sberbank/callback`,
    //     failUrl: `${process.env.GATEWAY_SERVER_URL}/sberbank/cancel`,
    //     description: `Пополнение баланса на ${input.amount} ${input.currency}`,
    //     currency: input.currency,
    //   }
    // );
    // console.log(`SberBank order: ${JSON.stringify(order)}`);
  }
}
