import { GatewayTimeoutException, Injectable, Logger } from '@nestjs/common';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { exec } from 'child_process';

@Injectable()
export class MyFatoorahService {
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
    const endPointUrl =
      process.env.DEMO_MODE != null
        ? 'https://apitest.myfatoorah.com/'
        : 'https://api.myfatoorah.com/';
    const userTrackingNumber = `${input.userId}@${input.userType}.id`;
    const requestObject = {
      tx_ref: transactionId,
      InvoiceAmount: input.amount,
      CurrencyIso: input.currency,
    };
    const initialPaymentResult = await firstValueFrom(
      this.httpService.post<InitiatePaymentResult>(
        `${endPointUrl}v2/InitiatePayment`,
        requestObject,
        { headers: { Authorization: `Bearer ${input.gateway.privateKey}` } }
      )
    );
    const gateway = initialPaymentResult.data.Data.PaymentMethods.filter(
      (method) => method.PaymentMethodCode == input.gateway.merchantId
    )[0];
    Logger.log(
      `MyFatoorah initialPaymentResult: ${JSON.stringify(initialPaymentResult)}`
    );
    // CallbackUrl won't work if localhost
    const executePaymentBody = {
      PaymentMethodId: gateway.PaymentMethodId,
      InvoiceValue: parseInt(input.amount),
      DisplayCurrencyIso: input.currency,
      CustomerReference: transactionId,
      CallBackUrl: `${process.env.GATEWAY_SERVER_URL}/myfatoorah/callback`,
    };
    const excutePaymentResult = await firstValueFrom(
      this.httpService.post<ExecutePaymentResult>(
        `${endPointUrl}v2/ExecutePayment`,
        executePaymentBody,
        {
          headers: { Authorization: `Bearer ${input.gateway.privateKey}` },
        }
      )
    );
    Logger.log(
      `MyFatoorah excutePaymentResult: ${JSON.stringify(excutePaymentResult)}`
    );
    return {
      invoiceId: transactionId,
      url: excutePaymentResult.data.Data.PaymentURL,
    };
  }
}

interface InitiatePaymentResult {
  IsSuccess: boolean;
  Message: string;
  Data: {
    PaymentMethods: MyFatoorahPaymentMethod[];
  };
}

interface MyFatoorahPaymentMethod {
  PaymentMethodId: number;
  PaymentMethodAr: string;
  PaymentMethodEn: string;
  PaymentMethodCode: string;
}

interface ExecutePaymentResult {
  Data: {
    InvoiceId: string;
    PaymentURL: string;
    CustomerReference: string;
    UserDefinedField: string;
  };
}
