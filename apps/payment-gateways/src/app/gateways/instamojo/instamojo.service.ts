import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import * as crypto from "crypto";

@Injectable()
export class InstaMojoService {
    constructor() {}

    async getPaymentLink(input: { gateway: PaymentGatewayEntity, userType: string, userId: string, currency: string, amount: string}): Promise<PaymentLinkResult> {
        const transactionId=`${input.userType}_${input.userId}_${new Date().getTime()}`;
        const Instamojo = require("instamojo-payment-nodejs");
        Instamojo.isSandboxMode(process.env.DEMO_MODE != undefined);
        Instamojo.setKeys(input.gateway.publicKey, input.gateway.privateKey);
        const options = {
            purpose: "Wallet Top-up",
            amount: input.amount,
            currency: input.currency,
            buyer_name: 'Unknown',
            email: `${input.userType}_${input.userId}@mobile.com`,
            phone: input.userId,
            redirect_url: `${process.env.GATEWAY_SERVER_URL}/instamojo/callback?gatewayId=${input.gateway.id}`,
        };
        const paymentData = Instamojo.PaymentData(options);
        const response = await Instamojo.createNewPaymentRequest(paymentData);
        console.log(response);
        return {
            url: `${process.env.GATEWAY_SERVER_URL}/instamojo/redirect?token=${response}&gatewayId=${input.gateway.id}`,
            invoiceId: transactionId
        }
    }
}

export interface ChargeDecryptedKey {
    amount: string,
    currency: string,
    status: 'success' | 'failed',
    checksum: string
}