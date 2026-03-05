import { Injectable } from '@nestjs/common';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
const Razorpay = require('razorpay');
import { PaymentLinkResult } from '../paypal/paypal.service';
@Injectable()
export class RazorPayService {
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
    const instance = new Razorpay({
      key_id: input.gateway.merchantId!,
      key_secret: input.gateway.privateKey,
    });
    const order = await instance.paymentLink.create({
      amount: parseInt(input.amount) * 100,
      currency: input.currency,
      accept_partial: false,
      reference_id: transactionId,
      callback_url: `${process.env.GATEWAY_SERVER_URL}/razorpay/callback`,
      customer: {
        name: `${input.userType}_${input.userId}`,
      },
      options: {
        order: {
          offers: [],
        },
      },
    });
    return {
      invoiceId: transactionId,
      url: order.short_url,
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string
  ): Promise<boolean> {
    return true;
  }
}
