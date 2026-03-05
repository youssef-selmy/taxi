import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import PayStack = require('paystack-node');
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class PaystackService {
    async getPaymentLink(apiKey: string, userType: string, userId: string, currency: string, amount: string): Promise<PaymentLinkResult> {
        const environment = 'prod';
        const transactionId=`${userType}_${userId}_${new Date().getTime()}`;
        const userTrackingNumber = `${userId}@${userType}.id`;
        const paystack = new PayStack(apiKey, environment);
        const transaction = await paystack.initializeTransaction({
            amount: Math.round(parseFloat(amount)) * 100,
            currency: currency,
            callback_url: `${process.env.GATEWAY_SERVER_URL}/paystack/callback`,
            email: userTrackingNumber,
            reference: transactionId
        });

        return {
            invoiceId: transactionId,
            url: transaction.body.data.authorization_url as string
        }
    }

    async verify(paymentGateway: PaymentGatewayEntity, transactionNumber: string): Promise<PaystackResponse> {
        const environment = 'prod';
        const paystack = new PayStack(paymentGateway.privateKey, environment);
        const response = await paystack.verifyTransaction({
            reference: transactionNumber
        });
        return response.body;
    }
}

interface PaystackResponse {
    status: boolean;
    message: string;
    data: {
        amount: number;
        currency: string;
        status: string;
    }
}