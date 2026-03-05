import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { HttpService } from "@nestjs/axios";
import { firstValueFrom } from 'rxjs';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class MyTMoneyService {
    constructor(
        private httpService: HttpService
    ) {}

    async getPaymentLink(input: { gateway: PaymentGatewayEntity, userType: string, userId: string, currency: string, amount: string}): Promise<PaymentLinkResult> {
        const transactionId=`${input.userType}_${input.userId}_${new Date().getTime()}`;
        const data: MyTMoneyDTO = {
            gatewayId: input.gateway.id,
            userType: input.userType,
            userId: parseInt(input.userId),
            amount: parseFloat(input.amount),
            transactionId,
            //serverUrl: dto.serverUrl,
            currency: input.currency
        }
        const base64Encoded = Buffer.from(JSON.stringify(data), 'utf8').toString('base64');
        return {
            url: `${process.env.GATEWAY_SERVER_URL}/mytmoney/redirect?token=${base64Encoded}`,
            invoiceId: transactionId
        };
    }
}
export interface MyTMoneyDTO {
    gatewayId: number;
    userType: string;
    userId: number;
    amount: number;
    transactionId: string;
    //serverUrl: string;
    currency: string;
}