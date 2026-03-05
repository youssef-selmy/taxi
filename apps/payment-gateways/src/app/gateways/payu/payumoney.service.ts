import { Currency, PayU } from '@ingameltd/payu';
import { Injectable } from '@nestjs/common';

import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentLinkResult } from '../paypal/paypal.service';

@Injectable()
export class PayUMoneyService {
    async getPaymentLink(input: { gateway: PaymentGatewayEntity, userType: string, userId: string, currency: string, amount: string }): Promise<PaymentLinkResult> {
        const transactionId = `${input.userType}_${input.userId}_${new Date().getTime()}`;
        const payU = new PayU(parseInt(input.userId), input.gateway.privateKey!, parseInt(input.gateway.merchantId!), input.gateway.merchantId!, {
            sandbox: false,
          });
          const result = await payU.createOrder({
            extOrderId: transactionId,
            notifyUrl: `${process.env.GATEWAY_SERVER_URL}/payumoney/callback`,
            customerIp: "127.0.0.1",
            continueUrl: `${process.env.GATEWAY_SERVER_URL}/payumoney/callback`,
            description: "My order",
            currencyCode: input.currency as Currency,
            totalAmount: parseFloat(input.amount),
            products: [
              { name: "Recharge account", quantity: 1, unitPrice: parseFloat(input.amount) },
            ],
          });
        return {
            invoiceId: transactionId,
            url: result.redirectUri
        };
    }

    async verify(paymentGateway: PaymentGatewayEntity, transactionNumber: string): Promise<boolean> {
        return true;
    }
}

interface RazorPayPaymentLinkResult {
    id: string
    amount: number
    currency: string,
    short_url: string
}
