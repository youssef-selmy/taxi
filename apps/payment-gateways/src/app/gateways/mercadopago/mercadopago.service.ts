import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import * as crypto from "crypto";
const mercadopago = require('mercadopago');

@Injectable()
export class MercadopagoService {
    constructor() {}

    async getPaymentLink(input: { gateway: PaymentGatewayEntity, userType: string, userId: string, currency: string, amount: string}): Promise<PaymentLinkResult> {
        const transactionId=`${input.userType}_${input.userId}_${new Date().getTime()}`;
        mercadopago.configure({
            access_token: input.gateway.privateKey
        });
        const verifyUrl = `${process.env.GATEWAY_SERVER_URL}/mercadopago/callback?gatewayId=${input.gateway.id}`;
        const preference = {
            items: [
                {
                    title: 'Recharge account',
                    unit_price: parseFloat(input.amount),
                    quantity: 1,
                    currency_id: input.currency
                }
            ],
            payer: {
                name: '',
                surname: '',
                phone: {
                    area_code: "1",
                    number: 6505551234
                }
            },
            back_urls: {
                success: verifyUrl,
                failure: verifyUrl,
                pending: verifyUrl
            },
            external_reference: transactionId,
            auto_return: "approved",
        };

        const order = await mercadopago.preferences.create(preference);
        return {
            url: `${process.env.GATEWAY_SERVER_URL}/mercadopago/redirect?token=${order.body.id}&gatewayId=${input.gateway.id}`,
            invoiceId: transactionId
        }
    }

}