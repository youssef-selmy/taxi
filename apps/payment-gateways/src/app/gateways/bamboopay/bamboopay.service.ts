import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';

@Injectable()
export class BambooPayService {
  constructor(private httpService: HttpService) {}

  async getPaymentLink(input: {
    gateway: PaymentGatewayEntity;
    userType: string;
    userPhone: string; // not used in BambooPay but kept for consistency
    userId: string;
    currency: string; // not used in BambooPay but kept for consistency
    amount: string;
  }): Promise<PaymentLinkResult> {
    const transactionId = `${input.userType}_${input.userId}_${Date.now()}`;
    const callbackUrl = `${process.env.GATEWAY_SERVER_URL}/bamboopay/callback?tx_ref=${transactionId}`;

    const requestBody = {
      payerName: `${input.userType} ${input.userId}`,
      matricule: transactionId,
      raisonSociale: 'Wallet Top-up',
      billingId: transactionId,
      transactionAmount: input.amount,
      merchant_id: input.gateway.merchantId,
      phone: input.userPhone,
      merchant_account: input.gateway.saltKey,
      phoneMerchant: '0000000000',
      return_url: callbackUrl,
      update_status_url: `${process.env.GATEWAY_SERVER_URL}/bamboopay/status?tx_ref=${transactionId}`,
    };

    const basicAuth = Buffer.from(
      `${input.gateway.publicKey}:${input.gateway.privateKey}`,
    ).toString('base64');

    try {
      const result = await firstValueFrom(
        this.httpService.post(
          'https://devfront-bamboopay.ventis.group/api/send',
          requestBody,
          {
            headers: {
              Authorization: `Basic ${basicAuth}`,
              'Content-Type': 'application/json',
            },
          },
        ),
      );

      return {
        invoiceId: transactionId,
        url: result.data.redirect_url,
      };
    } catch (e) {
      console.error('BambooPay error', e?.response?.data || e.message);
      throw e;
    }
  }
}
