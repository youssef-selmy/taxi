import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { GatewayToUserEntity } from '../database/gateway-to-user.entity';
import { AmazonPaymentServicesModule } from './amazon/amazon.module';
import { AmazonPaymentServicesService } from './amazon/amazon.service';
import { FlutterwaveModule } from './flutterwave/flutterwave.module';
import { FlutterwaveService } from './flutterwave/flutterwave.service';
import { MercadopagoModule } from './mercadopago/mercadopago.module';
import { MercadopagoService } from './mercadopago/mercadopago.service';
import { MIPSModule } from './mips/mips.module';
import { MIPSService } from './mips/mips.service';
import { MyTMoneyModule } from './my-t-money/my-t-money.module';
import { MyTMoneyService } from './my-t-money/my-t-money.service';
import { MyFatoorahModule } from './myfatoorah/myfatoorah.module';
import { MyFatoorahService } from './myfatoorah/myfatoorah.service';
import { PaypalModule } from './paypal/paypal.module';
import { PaypalService } from './paypal/paypal.service';
import { PaystackModule } from './paystack/paystack.module';
import { PaystackService } from './paystack/paystack.service';
import { PayTMModule } from './paytm/paytm.module';
import { PayTMService } from './paytm/paytm.service';
import { PayUMoneyModule } from './payu/payumoney.module';
import { PayUMoneyService } from './payu/payumoney.service';
import { RazorPayModule } from './razorpay/razorpay.module';
import { RazorPayService } from './razorpay/razorpay.service';
import { SberBankModule } from './sberbank/sberbank.module';
import { SberBankService } from './sberbank/sberbank.service';
import { StripeModule } from './stripe/stripe.module';
import { StripeService } from './stripe/stripe.service';
import { WayForPayModule } from './way-for-pay/way-for-pay.module';
import { WayForPayService } from './way-for-pay/way-for-pay.service';
import { InstaMojoModule } from './instamojo/instamojo.module';
import { InstaMojoService } from './instamojo/instamojo.service';
import { BinancePayModule } from './binance-pay/binance-pay.module';
import { BinancePayService } from './binance-pay/binance-pay.service';
import { OpenPixModule } from './openpix/openpix.module';
import { OpenPixService } from './openpix/openpix.service';
import { PayTRModule } from './paytr/paytr.module';
import { PayTRService } from './paytr/paytr.service';
import { PaymentEntity } from '../database/payment.entity';
import { BambooPayService } from './bamboopay/bamboopay.service';

@Module({
  imports: [
    HttpModule,
    AmazonPaymentServicesModule,
    PaypalModule,
    PaystackModule,
    StripeModule,
    FlutterwaveModule,
    RazorPayModule,
    MIPSModule,
    PayUMoneyModule,
    PayTMModule,
    MyTMoneyModule,
    MercadopagoModule,
    MyFatoorahModule,
    SberBankModule,
    WayForPayModule,
    BinancePayModule,
    OpenPixModule,
    InstaMojoModule,
    PayTRModule,
    TypeOrmModule.forFeature([GatewayToUserEntity, PaymentEntity]),
  ],
  providers: [
    AmazonPaymentServicesService,
    PaypalService,
    PaystackService,
    StripeService,
    FlutterwaveService,
    MIPSService,
    RazorPayService,
    MyTMoneyService,
    PayTMService,
    PayUMoneyService,
    MercadopagoService,
    MyFatoorahService,
    SberBankService,
    InstaMojoService,
    BinancePayService,
    OpenPixService,
    WayForPayService,
    BambooPayService,
    PayTRService,
  ],
  exports: [
    AmazonPaymentServicesService,
    PaypalService,
    PaystackService,
    StripeService,
    RazorPayService,
    FlutterwaveService,
    MIPSService,
    PayTMService,
    MyTMoneyService,
    PayUMoneyService,
    MercadopagoService,
    MyFatoorahService,
    SberBankService,
    InstaMojoService,
    BinancePayService,
    OpenPixService,
    WayForPayService,
    BambooPayService,
    PayTRService,
  ],
})
export class GatewaysModule {}
