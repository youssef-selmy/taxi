import { Injectable } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { HttpService } from '@nestjs/axios';
import * as paytmChecksum from 'paytmchecksum';
import { firstValueFrom } from 'rxjs';
@Injectable()
export class PayTMService {
  constructor(private httpService: HttpService) {}
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

    const callbackUrl = `${process.env.GATEWAY_SERVER_URL}/paytm/callback`;
    const body = {
      merchantRequestId: transactionId,
      mid: input.gateway.merchantId,
      linkName: 'Recharge',
      linkDescription: 'Recharge wallet',
      linkType: 'FIXED',
      amount: input.amount,
      statusCallbackUrl: callbackUrl,
    };
    const bodyStr = JSON.stringify(body);
    const url = `${
      process.env.DEMO_MODE == null
        ? 'https://securegw.paytm.in/link/create'
        : 'https://securegw-stage.paytm.in/link/create'
    }`;
    const checksum = await paytmChecksum.generateSignature(
      bodyStr,
      input.gateway.privateKey,
    );
    console.log(checksum);
    const result = await firstValueFrom(
      this.httpService.post(url, body, {
        headers: {
          tokenType: 'AES',
          signature: checksum,
        },
      }),
    );
    console.log(result.data);
    // Paytm.MerchantProperties.setCallbackUrl(callbackUrl);

    // Paytm.MerchantProperties.initialize(environment, input.gateway.merchantId, input.gateway.privateKey, process.env.TEST_MODE == null ? 'DEFAULT' : 'WEBSTAGING');
    // var channelId = Paytm.EChannelId.WEB;
    // var txnAmount = Paytm.Money.constructWithCurrencyAndValue(Paytm.EnumCurrency.getEnumByCurrency(input.currency), input.amount);
    // var userInfo = new Paytm.UserInfo(`${input.userType}_${input.userId}`);
    // var paymentDetailBuilder = new Paytm.PaymentDetailBuilder(channelId, transactionId, txnAmount, userInfo);
    // var paymentDetail = paymentDetailBuilder.build();
    // Paytm.PaymentDetailBuilder(channelId)
    // var response = await Paytm.Payment.createTxnToken(paymentDetail);
    // console.log(response.responseObject.body.txnToken);
    return {
      invoiceId: transactionId,
      url: result.data.shortUrl,
      //url: `${process.env.GATEWAY_SERVER_URL}/paytm/redirect?transactionId=${transactionId}&token=${response.responseObject.body.txnToken}`
    };
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<boolean> {
    return true;
  }
}
