import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { WFP, WFP_CONFIG } from 'overshom-wayforpay';
import { PaymentCurrencyType } from 'overshom-wayforpay/dist/wfp/types/currency.type';

@Injectable()
export class WayForPayService {
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
    WFP_CONFIG.DEFAULT_PAYMENT_CURRENCY =
      input.currency as unknown as PaymentCurrencyType;
    const wfp = new WFP({
      MERCHANT_ACCOUNT: input.gateway.merchantId!,
      MERCHANT_SECRET_KEY: input.gateway.privateKey!,
      MERCHANT_DOMAIN_NAME: input.gateway.publicKey!,
      SERVICE_URL: `${process.env.GATEWAY_SERVER_URL}/wayforpay/callback`,
    });
    const invoice = await wfp.createInvoiceUrl({
      orderReference: transactionId,
      productName: ['Wallet'],
      productCount: [1],
      productPrice: [parseFloat(input.amount)],
    });
    return {
      invoiceId: transactionId,
      url: invoice.value!.invoiceUrl,
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<boolean> {
    return true;
  }
}
