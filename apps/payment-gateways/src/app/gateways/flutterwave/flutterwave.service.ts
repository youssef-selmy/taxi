import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class FlutterwaveService {
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
    const userTrackingNumber = `${input.userId}@${input.userType}.id`;
    const requestObject = {
      tx_ref: transactionId,
      amount: input.amount,
      currency: input.currency,
      payment_options: 'card',
      redirect_url: `${process.env.GATEWAY_SERVER_URL}/flutterwave/callback`,
      customer: {
        email: userTrackingNumber,
      },
      customizations: {
        title: 'Wallet Top-up',
        description: 'Charging your in-app wallet',
      },
    };
    try {
      const result = await firstValueFrom(
        this.httpService.post(
          'https://api.flutterwave.com/v3/payments',
          requestObject,
          { headers: { Authorization: `Bearer ${input.gateway.privateKey}` } }
        )
      );
      return {
        invoiceId: transactionId,
        url: result.data.data.link as string,
      };
    } catch (e) {
      console.log(e);
      throw e;
    }
  }
}
