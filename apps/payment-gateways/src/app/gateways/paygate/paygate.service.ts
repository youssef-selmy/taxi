import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class PayGateService {
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
    return {
      invoiceId: transactionId,
      url: '1',
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string
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
