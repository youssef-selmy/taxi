import { HttpException, Injectable, Logger } from '@nestjs/common';
import { PaymentGatewayType } from '@ridy/database';
import {
  ChargeSavedPaymentMethodBody,
  IntentResult,
  GetPaymentLinkBody,
  SetupSavedPaymentMethodDecryptedBody,
  SetupPayoutMethodBody,
} from '@ridy/database';
import {
  PaymentLinkResult,
  PaypalService,
} from './gateways/paypal/paypal.service';
import { InjectRepository } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from './database/payment-gateway.entity';
import { Repository } from 'typeorm';
import { AmazonPaymentServicesService } from './gateways/amazon/amazon.service';
import { PaymentService } from './payment/payment.service';
import { PaystackService } from './gateways/paystack/paystack.service';
import { FlutterwaveService } from './gateways/flutterwave/flutterwave.service';
import { MIPSService } from './gateways/mips/mips.service';
import { MyTMoneyService } from './gateways/my-t-money/my-t-money.service';
import { StripeService } from './gateways/stripe/stripe.service';
import { RazorPayService } from './gateways/razorpay/razorpay.service';
import { PayUMoneyService } from './gateways/payu/payumoney.service';
import { PayTMService } from './gateways/paytm/paytm.service';
import { MyFatoorahService } from './gateways/myfatoorah/myfatoorah.service';
import { SberBankService } from './gateways/sberbank/sberbank.service';
import { MercadopagoService } from './gateways/mercadopago/mercadopago.service';
import { WayForPayService } from './gateways/way-for-pay/way-for-pay.service';
import { InstaMojoService } from './gateways/instamojo/instamojo.service';
import { BinancePayService } from './gateways/binance-pay/binance-pay.service';
import { OpenPixService } from './gateways/openpix/openpix.service';
import { HttpService } from '@nestjs/axios';
import { CryptoService } from './crypto/crypto.service';
import { firstValueFrom } from 'rxjs';
import { SavedPaymentMethodEntity } from './database/saved-payment-method.entity';
import { GatewayToUserEntity } from './database/gateway-to-user.entity';
import { PaymentStatus } from './database/payment.entity';
import { PayoutMethodEntity } from './database/payout-method.entity';
import { PayoutMethodType } from '@ridy/database';
import { PayTRService } from './gateways/paytr/paytr.service';
import { BambooPayService } from './gateways/bamboopay/bamboopay.service';

@Injectable()
export class AppService {
  constructor(
    @InjectRepository(PaymentGatewayEntity)
    private gatewayRepository: Repository<PaymentGatewayEntity>,
    @InjectRepository(SavedPaymentMethodEntity)
    private savedPaymentMethodRepo: Repository<SavedPaymentMethodEntity>,
    @InjectRepository(GatewayToUserEntity)
    private gatewayToUserRepo: Repository<GatewayToUserEntity>,
    @InjectRepository(PayoutMethodEntity)
    private payoutMethodRepo: Repository<PayoutMethodEntity>,
    private amazonPaymentServices: AmazonPaymentServicesService,
    private paymentService: PaymentService,
    private payPalService: PaypalService,
    private flutterwaveService: FlutterwaveService,
    private payStackService: PaystackService,
    private mipsService: MIPSService,
    private mytMoneyService: MyTMoneyService,
    private stripService: StripeService,
    private razorPayService: RazorPayService,
    private payUMoneyService: PayUMoneyService,
    private payTMService: PayTMService,
    private myFatoorahService: MyFatoorahService,
    private sberBankService: SberBankService,
    private mercadopagoService: MercadopagoService,
    private wayForPayService: WayForPayService,
    private instamojoService: InstaMojoService,
    private binancePayService: BinancePayService,
    private openPixService: OpenPixService,
    private bambooPayService: BambooPayService,
    private paytrService: PayTRService,
    private httpService: HttpService,
    private cryptoService: CryptoService,
  ) {}

  async createPaymentLink(input: GetPaymentLinkBody): Promise<IntentResult> {
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: input.paymentGatewayId,
    });
    let paymentLink: PaymentLinkResult;
    switch (gateway.type) {
      case PaymentGatewayType.AmazonPaymentServices:
        paymentLink = await this.amazonPaymentServices.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.PayPal:
        paymentLink = await this.payPalService.getPaymentLink(
          gateway.merchantId!,
          gateway.privateKey!,
          input.currency,
          input.amount,
        );
        break;

      case PaymentGatewayType.Paystack:
        paymentLink = await this.payStackService.getPaymentLink(
          gateway.privateKey!,
          input.userType,
          input.userId,
          input.currency,
          input.amount,
        );
        break;

      case PaymentGatewayType.Stripe:
        paymentLink = await this.stripService.createPaymentLink({
          shouldPreauth: input.shouldPreauth == '1',
          gatewayId: gateway.id,
          userType: input.userType,
          userId: input.userId,
          payoutData: input.payoutData,
          privateKey: gateway.privateKey!,
          currency: input.currency,
          amount: input.amount,
        });
        break;

      case PaymentGatewayType.Instamojo:
        paymentLink = await this.instamojoService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.Flutterwave:
        paymentLink = await this.flutterwaveService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.MIPS:
        paymentLink = await this.mipsService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.MyTMoney:
        paymentLink = await this.mytMoneyService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.Razorpay:
        paymentLink = await this.razorPayService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.PayU:
        paymentLink = await this.payUMoneyService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.Paytm:
        paymentLink = await this.payTMService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.WayForPay:
        paymentLink = await this.wayForPayService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.MercadoPago:
        paymentLink = await this.mercadopagoService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.MyFatoorah:
        paymentLink = await this.myFatoorahService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.SberBank:
        paymentLink = await this.sberBankService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.BinancePay:
        paymentLink = await this.binancePayService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.OpenPix:
        paymentLink = await this.openPixService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.PayTR:
        paymentLink = await this.paytrService.getPaymentLink({
          gateway,
          ...input,
        });
        break;

      case PaymentGatewayType.BambooPay:
        paymentLink = await this.bambooPayService.getPaymentLink({
          gateway,
          ...input,
          userPhone: '6505551234',
        });
        break;

      case PaymentGatewayType.CustomLink:
        const invoiceId = `${input.userType}_${
          input.userId
        }_${new Date().getTime()}`;
        paymentLink = {
          invoiceId,
          url: gateway.publicKey ?? gateway.privateKey!,
        };
        break;
    }
    Logger.log(paymentLink, 'AppService.createPaymentLink');
    await this.paymentService.createRecord({
      transactionNumber: paymentLink!.invoiceId,
      paymentInterface: input,
      orderNumber: input.orderNumber ?? undefined,
      externalReferenceNumber: paymentLink!.externalReferenceNumber,
    });
    return {
      status: 'redirect',
      url: paymentLink!.url,
    };
  }

  async capturePayment(input: {
    id: string;
    amount: number;
  }): Promise<IntentResult> {
    let payment = await this.paymentService.getOne(input.id);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    let result;
    switch (gateway.type) {
      case PaymentGatewayType.Stripe:
        result = await this.stripService.capturePayment({
          payment,
          gateway,
          transactionNumber: payment.externalReferenceNumber!,
          amount: input.amount,
        });
        break;
      default:
        throw new Error('Pre-authentication is not supported for this gateway');
    }
    if (!result) return { status: 'failed' };
    payment = await this.paymentService.markAsCaptured(
      payment.id,
      input.amount,
    );
    const encrypted =
      await this.paymentService.getEncryptedWithPayment(payment);
    if (result.status == 'success') {
      await firstValueFrom(
        this.httpService.get(
          `${payment.returnUrl}?token=${encrypted}&redirect=0`,
        ),
      );
    }
    return result;
  }

  async cancelCapture(input: { id: string }): Promise<IntentResult> {
    let payment = await this.paymentService.getOne(input.id);
    const gateway = await this.gatewayRepository.findOneByOrFail({
      id: payment.gatewayId,
    });
    let result;
    switch (gateway.type) {
      case PaymentGatewayType.Stripe:
        result = await this.stripService.cancelPreauth({
          payment,
          gateway,
          transactionNumber: payment.externalReferenceNumber!,
        });
        break;
      default:
        throw new Error('Pre-authentication is not supported for this gateway');
    }
    payment = await this.paymentService.markAsCanceled(payment.id);
    return result;
  }

  async chargeSavedPaymentMethod(
    input: ChargeSavedPaymentMethodBody,
  ): Promise<IntentResult> {
    const paymentMethod = await this.savedPaymentMethodRepo.findOneOrFail({
      where: { id: parseInt(input.savedPaymentMethodId) },
      relations: { paymentGateway: true },
    });
    const internalUserId = `${input.userType}_${input.userId}`;
    const gateway = paymentMethod.paymentGateway;
    const gatewayToUser = await this.gatewayToUserRepo.findOneOrFail({
      where: {
        gatewayId: gateway!.id,
        internalUserId: internalUserId,
      },
    });
    const token = internalUserId + '_' + new Date().getTime();
    let payment = this.paymentService.paymentRepository.create({
      transactionNumber: token,
      savedPaymentMethodId: parseInt(input.savedPaymentMethodId),
      returnUrl: input.returnUrl,
      amount: input.amount,
      currency: input.currency,
      userType: input.userType,
      userId: input.userId.toString(),
      orderNumber: input.orderNumber,
      status: PaymentStatus.Processing,
    });
    await this.paymentService.paymentRepository.save(payment);
    let result;
    switch (gateway?.type) {
      case PaymentGatewayType.Stripe:
        result = await this.stripService.chargeSavedPaymentMethod({
          gatewayPrivateKey: gateway.privateKey,
          customerId: gatewayToUser.externalReferenceNumber,
          token: paymentMethod.token,
          currency: input.currency,
          amount: input.amount,
          returnUrl: input.returnUrl,
          payoutData: input.payoutData,
          transactionNumber: payment.transactionNumber,
          captureImmediately: input.captureImmediately,
        });
        break;

      default:
        throw new HttpException('Unsupported payment gateway', 400);
    }
    let paymentStatus = PaymentStatus.Processing;
    switch (result.status) {
      case 'success':
        paymentStatus = PaymentStatus.Success;
        break;
      case 'processing':
        paymentStatus = PaymentStatus.Processing;
        break;
      case 'failed':
        paymentStatus = PaymentStatus.Failed;
        break;
      case 'canceled':
        paymentStatus = PaymentStatus.Canceled;
        break;
      case 'authorized':
        paymentStatus = PaymentStatus.Authorized;
        break;
    }
    await this.paymentService.paymentRepository.update(payment.id, {
      externalReferenceNumber: result.transactionNumber,
      status: paymentStatus,
    });

    if (result.status == 'success' || result.status == 'authorized') {
      payment = await this.paymentService.paymentRepository.findOneByOrFail({
        id: payment.id,
      });
      const token = await this.paymentService.getEncryptedWithPayment(payment);
      Logger.log(
        `Redirecting to ${payment.returnUrl} with token ${token}`,
        'AppService.chargeSavedPaymentMethod',
      );
      await firstValueFrom(
        this.httpService.get(payment.returnUrl, {
          params: { token, redirect: '0' },
        }),
      );
    }
    return result;
  }

  async setupSavedPaymentMethod(token: string): Promise<IntentResult> {
    const decrypted: SetupSavedPaymentMethodDecryptedBody = JSON.parse(
      await this.cryptoService.decrypt(token),
    );
    Logger.log(JSON.stringify(decrypted), 'setupSavedPaymentMethod');
    const gateway = await this.gatewayRepository.findOneOrFail({
      where: { id: parseInt(decrypted.gatewayId) },
    });
    let paymentLink: PaymentLinkResult;

    switch (gateway.type) {
      case PaymentGatewayType.Stripe:
        paymentLink = await this.stripService.setupSavedMethod({
          paymentGatewayId: gateway.id.toString(),
          paymentGatewayPrivateKey: gateway.privateKey!,
          userType: decrypted.userType,
          userId: decrypted.userId,
          currency: decrypted.currency,
        });
        break;

      default:
        throw new HttpException('Unsupported payment gateway', 400);
    }
    await this.paymentService.createRecord({
      transactionNumber: paymentLink!.invoiceId,
      paymentInterface: {
        userType: decrypted.userType,
        userId: decrypted.userId,
        currency: decrypted.currency,
        payoutData: null,
        amount: '0',
        paymentGatewayId: gateway.id,
        shouldPreauth: '0',
        returnUrl: decrypted.returnUrl,
        orderNumber: null,
      },
      orderNumber: undefined,
      externalReferenceNumber: paymentLink!.externalReferenceNumber,
    });
    return {
      status: 'success',
      url: paymentLink!.url,
    };
  }

  async getPayoutLinkUrl(input: SetupPayoutMethodBody): Promise<IntentResult> {
    const payoutMethod = await this.payoutMethodRepo.findOneOrFail({
      where: { id: input.payoutMethodId },
    });
    let result;
    switch (payoutMethod.type) {
      case PayoutMethodType.Stripe:
        result = await this.stripService.getPayoutLinkUrl({
          method: payoutMethod,
          userType: 'driver',
          userId: input.driverId,
          returnUrl: input.returnUrl,
        });
        break;

      default:
        throw new HttpException('Unsupported payout method', 400);
    }
    return {
      status: 'success',
      url: result,
    };
  }
}
