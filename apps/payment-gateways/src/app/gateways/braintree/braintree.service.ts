import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class BraintreeService {
  async getPaymentLink(input: {
    gateway: PaymentGatewayEntity;
    userType: string;
    userId: string;
    currency: string;
    amount: string;
  }): Promise<PaymentLinkResult> {
    //   const transactionId = `${input.userType}_${
    //     input.userId
    //   }_${new Date().getTime()}`;
    //   const braintree = new gw.BraintreeGateway({
    //     environment: process.env.DEMO_MODE != undefined ? gw.Environment.Sandbox : gw.Environment.Production,
    //     merchantId: this.gateway.merchantId,
    //     publicKey: this.gateway.publicKey,
    //     privateKey: this.gateway.privateKey
    // });
    // const res = await braintree.transaction.sale({
    //     amount: dto.amount.toString(),
    //     paymentMethodNonce: dto.token,
    //     options: {
    //         submitForSettlement: true
    //     }
    // });
    //   return {
    //     invoiceId: transactionId,
    //     url: `${process.env.GATEWAY_SERVER_URL}/amazon/redirect?token=${base64Encoded}`,
    //   };
    return {
      url: '',
      invoiceId: '',
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<boolean> {
    return true;
  }
}
