import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class AmazonPaymentServicesService {
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
    const data: PayFortDTO = {
      transactionId,
      gatewayId: input.gateway.id,
      userType: input.userType,
      userId: input.userId,
      amount: parseFloat(input.amount),
      currency: input.currency,
    };
    const base64Encoded = Buffer.from(JSON.stringify(data), 'utf8').toString(
      'base64',
    );
    return {
      invoiceId: transactionId,
      url: `${process.env.GATEWAY_SERVER_URL}/amazon/redirect?token=${base64Encoded}`,
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<boolean> {
    return true;
  }
}

export class PayFortDTO {
  transactionId!: string;
  gatewayId!: number;
  userType!: string;
  userId!: string;
  amount!: number;
  currency!: string;
}
