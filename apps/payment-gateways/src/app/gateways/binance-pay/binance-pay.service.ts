import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { createHmac, randomBytes } from 'crypto';
import { Agent } from 'https';

@Injectable()
export class BinancePayService {
  constructor(private httpService: HttpService) {}

  async getPaymentLink(input: {
    gateway: PaymentGatewayEntity;
    userType: string;
    userId: string;
    currency: string;
    amount: string;
  }): Promise<PaymentLinkResult> {
    const transactionId = `${input.userType}z${
      input.userId
    }z${new Date().getTime()}`;
    const body = {
      env: {
        terminalType: 'APP',
      },
      merchantTradeNo: transactionId,
      fiatAmount: input.amount,
      fiatCurrency: input.currency,
      goods: {
        goodsType: '02',
        goodsCategory: '9000',
        referenceGoodsId: '1',
        goodsName: 'Wallet top-up',
        goodsUnitAmount: {
          amount: input.amount,
          currency: input.currency,
        },
      },
      description: 'Wallet top-up',
      returnUrl: `${process.env.GATEWAY_SERVER_URL}/binance/callback`,
      cancelUrl: `${process.env.GATEWAY_SERVER_URL}/binance/callback`,
    };

    try {
      const binanceServerCall = await this.callBinancePay<BinancePayResponse>(
        input.gateway,
        'https://bpay.binanceapi.com/binancepay/openapi/v2/order',
        body,
      );
      console.log(binanceServerCall.data.checkoutUrl);
      if (binanceServerCall.status !== 'SUCCESS')
        throw new Error(binanceServerCall.errorMessage);
      return {
        invoiceId: transactionId,
        url: binanceServerCall.data.checkoutUrl,
      };
    } catch (e) {
      console.log(e);
      throw e;
    }
  }

  async getPublicKey(
    gateway: PaymentGatewayEntity,
  ): Promise<BinancePayGetPublicKeyResponse> {
    return this.callBinancePay<BinancePayGetPublicKeyResponse>(
      gateway,
      'https://bpay.binanceapi.com/binancepay/openapi/certificates',
      {},
    );
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<boolean> {
    return true;
  }

  async callBinancePay<T>(
    gateway: PaymentGatewayEntity,
    url: string,
    body: {},
  ): Promise<T> {
    const nonce = randomBytes(32).toString('hex').substring(0, 32);
    const timestamp = Date.now();
    const payload_to_sign =
      timestamp + '\n' + nonce + '\n' + JSON.stringify(body) + '\n';
    const signature = createHmac('sha512', gateway.privateKey)
      .update(payload_to_sign)
      .digest('hex')
      .toUpperCase();
    const binanceServerCall = await firstValueFrom(
      this.httpService.post<T>(url, body, {
        headers: {
          'content-type': 'application/json',
          'BinancePay-Timestamp': timestamp,
          'BinancePay-Nonce': nonce,
          'BinancePay-Certificate-SN': gateway.publicKey!,
          'BinancePay-Signature': signature,
          httpsAgent: new Agent({
            rejectUnauthorized: false,
          }) as any,
        },
      }),
    );
    return binanceServerCall.data;
  }
}

export interface BinancePayResponse {
  status: 'SUCCESS' | 'FAIL';
  code: string;
  data: {
    prepayId: string;
    checkoutUrl: string;
  };
  errorMessage: string;
}

export interface BinancePayGetPublicKeyResponse {
  status: 'SUCCESS' | 'FAIL';
  data: [{ certSerial: string; certPublic: string }];
}
