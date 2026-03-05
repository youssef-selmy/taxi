import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Stripe } from 'stripe';
import { Repository } from 'typeorm';
import { GatewayToUserEntity } from '../../database/gateway-to-user.entity';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentLinkResult } from '../paypal/paypal.service';
import { IntentResult, PaymentPayoutData, PaymentStatus } from '@ridy/database';
import { PayoutMethodEntity } from '../../database/payout-method.entity';
import { PaymentEntity } from '../../database/payment.entity';

@Injectable()
export class StripeService {
  constructor(
    @InjectRepository(GatewayToUserEntity)
    private gatewayToUserRepo: Repository<GatewayToUserEntity>,
    @InjectRepository(PaymentEntity)
    private paymentRepo: Repository<PaymentEntity>,
  ) {}

  async createPaymentLink(input: {
    gatewayId: number;
    userType: string;
    userId: string;
    privateKey: string;
    payoutData: PaymentPayoutData | null;
    currency: string;
    amount: string;
    shouldPreauth: boolean;
  }): Promise<PaymentLinkResult> {
    const internalUserId = `${input.userType}_${input.userId}`;
    const transactionId = `${internalUserId}_${new Date().getTime()}`;
    const instance = new Stripe(input.privateKey, {
      apiVersion: '2025-07-30.basil',
    });
    const externalCustomerId = await this.getCustomerId({
      paymentGatewayId: input.gatewayId.toString(),
      paymentGatewayPrivateKey: input.privateKey,
      userId: input.userId,
      userType: input.userType,
    });
    const intent = await instance.checkout.sessions.create({
      customer: externalCustomerId,
      line_items: [
        {
          price_data: {
            currency: input.currency,
            product_data: {
              name: 'Add funds',
            },
            unit_amount: Math.ceil(parseFloat(input.amount) * 100),
          },
          quantity: 1,
        },
      ],

      mode: 'payment',
      success_url: `${process.env.GATEWAY_SERVER_URL}/stripe/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.GATEWAY_SERVER_URL}/stripe/cancel?session_id={CHECKOUT_SESSION_ID}`,
      payment_intent_data: {
        application_fee_amount: input.payoutData?.platformFee,
        transfer_data:
          input.payoutData == null
            ? undefined
            : {
                destination: input.payoutData.destinationAccount,
              },
        setup_future_usage: 'off_session',
        capture_method: input.shouldPreauth ? 'manual' : 'automatic',
      },
    });
    Logger.log(intent, 'createPaymentLink intent');
    return {
      invoiceId: transactionId,
      url: intent.url!,
      externalReferenceNumber: intent.id,
    };
  }

  async getCustomerId(input: {
    paymentGatewayId: string;
    paymentGatewayPrivateKey: string;
    userType: string;
    userId: string;
  }): Promise<string> {
    const internalUserId = `${input.userType}_${input.userId}`;
    const gatewayToUserEntity = await this.gatewayToUserRepo.findOneBy({
      internalUserId: internalUserId,
    });
    if (gatewayToUserEntity == null) {
      const newCustomer = await this.createCustomer({
        apiKey: input.paymentGatewayPrivateKey,
        userType: input.userType,
        userId: input.userId,
      });
      await this.gatewayToUserRepo.insert({
        internalUserId,
        externalReferenceNumber: newCustomer.id,
        gatewayId: parseInt(input.paymentGatewayId),
      });
      return newCustomer.id;
    } else {
      // validate that the customer id belongs to the payment processor
      const instance = new Stripe(input.paymentGatewayPrivateKey, {
        apiVersion: '2025-07-30.basil',
      });
      const customer = await instance.customers.retrieve(
        gatewayToUserEntity.externalReferenceNumber,
      );
      if (customer == null) {
        const newCustomer = await this.createCustomer({
          apiKey: input.paymentGatewayPrivateKey,
          userType: input.userType,
          userId: input.userId,
        });
        await this.gatewayToUserRepo.insert({
          internalUserId,
          externalReferenceNumber: newCustomer.id,
          gatewayId: parseInt(input.paymentGatewayId),
        });
        // delete the stale customerId
        await this.gatewayToUserRepo.delete({
          internalUserId: internalUserId,
          gatewayId: parseInt(input.paymentGatewayId),
          externalReferenceNumber: gatewayToUserEntity.externalReferenceNumber,
        });
        return newCustomer.id;
      }
      return gatewayToUserEntity.externalReferenceNumber;
    }
  }

  async setupSavedMethod(input: {
    paymentGatewayId: string;
    paymentGatewayPrivateKey: string;
    userType: string;
    userId: string;
    currency: string;
  }): Promise<PaymentLinkResult> {
    const instance = new Stripe(input.paymentGatewayPrivateKey, {
      apiVersion: '2025-07-30.basil',
    });
    const customerId = await this.getCustomerId({
      ...input,
    });
    const internalUserId = `${input.userType}_${input.userId}`;
    const transactionId = `${internalUserId}_${new Date().getTime()}`;
    const intent = await instance.checkout.sessions.create({
      customer: customerId,
      mode: 'setup',
      currency: input.currency,
      metadata: {
        userId: input.userId,
        userType: input.userType,
        gatewayId: input.paymentGatewayId,
      },
      success_url: `${process.env.GATEWAY_SERVER_URL}/stripe/success_attach?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${process.env.GATEWAY_SERVER_URL}/stripe/cancel_attach?session_id={CHECKOUT_SESSION_ID}`,
    });
    Logger.log(intent, 'setupSavedMethod');
    return {
      url: intent.url!,
      invoiceId: transactionId,
      externalReferenceNumber: intent.id,
    };
  }

  async chargeSavedPaymentMethod(input: {
    gatewayPrivateKey: string;
    token: string;
    customerId: string;
    currency: string;
    amount: number;
    returnUrl: string;
    transactionNumber: string;
    payoutData: PaymentPayoutData | null;
    captureImmediately: boolean;
  }): Promise<IntentResult & { transactionNumber: string }> {
    const instance = new Stripe(input.gatewayPrivateKey, {
      apiVersion: '2025-07-30.basil',
    });
    Logger.log(input, 'chargeSavedPaymentMethod input');

    // Step 1: Create without confirmation
    const paymentIntent = await instance.paymentIntents.create({
      payment_method: input.token,
      customer: input.customerId,
      currency: input.currency,
      amount: Math.ceil(input.amount * 100),
      application_fee_amount:
        input.payoutData?.platformFee == null
          ? undefined
          : Math.ceil(input.payoutData.platformFee * 100),
      transfer_data:
        input.payoutData?.destinationAccount == null
          ? undefined
          : {
              destination: input.payoutData?.destinationAccount,
            },
      capture_method: input.captureImmediately ? 'automatic' : 'manual',

      confirm: true,
      return_url: `${process.env.GATEWAY_SERVER_URL}/stripe/success_charge_saved_payment_method?transactionNumber=${input.transactionNumber}`,
    });

    Logger.log(paymentIntent, 'chargeSavedPaymentMethod.paymentIntent');

    if (
      paymentIntent.status === 'requires_action' &&
      paymentIntent.next_action?.type === 'redirect_to_url'
    ) {
      return {
        status: 'redirect',
        transactionNumber: paymentIntent.id,
        url: paymentIntent.next_action.redirect_to_url.url!,
      };
    } else if (paymentIntent.status === 'succeeded') {
      return {
        status: 'success',
        transactionNumber: paymentIntent.id,
      };
    } else if (paymentIntent.status === 'requires_capture') {
      return {
        status: 'authorized',
        transactionNumber: paymentIntent.id,
      };
    } else {
      throw new Error(
        'Unhandled payment intent status: ' + paymentIntent.status,
      );
    }
  }

  async getSession(
    gateway: PaymentGatewayEntity,
    sessionId: string,
  ): Promise<Stripe.Checkout.Session> {
    const instance = new Stripe(gateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    const session = await instance.checkout.sessions.retrieve(sessionId);
    return session;
  }

  async getSetupIntentPaymentMethodDetails(
    gateway: PaymentGatewayEntity,
    intentToken: string,
  ): Promise<Stripe.PaymentMethod> {
    const instance = new Stripe(gateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    const intent = await instance.setupIntents.retrieve(intentToken, {
      expand: ['payment_method'],
    });
    return intent.payment_method as Stripe.PaymentMethod;
  }

  private async createCustomer(input: {
    apiKey: string;
    userType: string;
    userId: string;
  }): Promise<Stripe.Response<Stripe.Customer>> {
    const instance = new Stripe(input.apiKey, {
      apiVersion: '2025-07-30.basil',
    });
    const customer = await instance.customers.create({
      name: `${input.userType}_${input.userId}`,
    });
    return customer;
  }

  async capturePayment(input: {
    payment: PaymentEntity;
    gateway: PaymentGatewayEntity;
    transactionNumber: string;
    amount: number;
  }): Promise<IntentResult> {
    Logger.log(input, 'capturePayment input');
    const instance = new Stripe(input.gateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    if (input.payment.savedPaymentMethodId != null) {
      const captureResult = await instance.paymentIntents.capture(
        input.transactionNumber,
        {
          amount_to_capture: Math.ceil(input.amount * 100),
        },
      );
      const result = this.handlePaymentIntentStatus(captureResult);
      return result;
    } else {
      const session = await instance.checkout.sessions.retrieve(
        input.transactionNumber,
      );
      const captureResult = await instance.paymentIntents.capture(
        session.payment_intent as unknown as string,
        {
          amount_to_capture: Math.ceil(input.amount * 100),
        },
      );
      const result = this.handlePaymentIntentStatus(captureResult);
      return result;
    }
  }

  handlePaymentIntentStatus(paymentIntent: Stripe.PaymentIntent): IntentResult {
    if (paymentIntent.status == 'requires_action') {
      if (paymentIntent.next_action?.redirect_to_url) {
        return {
          status: 'redirect',
          url: paymentIntent.next_action.redirect_to_url.url!,
        };
      } else {
        throw new Error('Unknown next action');
      }
    } else if (paymentIntent.status == 'succeeded') {
      return {
        status: 'success',
      };
    } else if (paymentIntent.status == 'canceled') {
      return {
        status: 'failed',
      };
    } else {
      Logger.error(
        `Unhandled payment intent status: ${paymentIntent}`,
        'StripeService.handlePaymentIntentStatus',
      );
      throw new Error('Unknown payment intent status ');
    }
  }

  async cancelPreauth(input: {
    payment: PaymentEntity;
    gateway: PaymentGatewayEntity;
    transactionNumber: string;
  }): Promise<IntentResult> {
    const instance = new Stripe(input.gateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    if (input.payment.savedPaymentMethodId != null) {
      const captureResult = await instance.paymentIntents.cancel(
        input.transactionNumber,
      );
      return this.handlePaymentIntentStatus(captureResult);
    } else {
      const session = await instance.checkout.sessions.retrieve(
        input.transactionNumber,
      );
      const captureResult = await instance.paymentIntents.cancel(
        session.payment_intent as unknown as string,
      );
      const result = this.handlePaymentIntentStatus(captureResult);
      return result;
    }
  }

  // async getPaymentLink(
  //   userType: string,
  //   userId: string,
  //   merchantId: string,
  //   privateKey: string,
  //   currency: string,
  //   amount: string
  // ): Promise<PaymentLinkResult> {
  //   const internalUserId = `${userType}_${userId}`;
  //   const transactionId = `${internalUserId}_${new Date().getTime()}`;
  //   const instance = new Stripe(privateKey, { apiVersion: '2025-07-30.basil' });
  //   const session = await instance.checkout.sessions.create({
  //     payment_method_types: ['card'],
  //     line_items: [
  //       {
  //         price_data: {
  //           currency: currency,
  //           product_data: {
  //             name: 'Top-up wallet',
  //           },
  //           unit_amount: Math.round(parseFloat(amount)) * 100,
  //         },
  //         quantity: 1,
  //       },
  //     ],
  //     mode: 'payment',
  //     success_url: `${process.env.GATEWAY_SERVER_URL}/stripe/success?transactionId=${transactionId}`,
  //     cancel_url: `${process.env.GATEWAY_SERVER_URL}/stripe/cancel?transactionId=${transactionId}`,
  //   });
  //   return {
  //     invoiceId: transactionId,
  //     url: session.url!,
  //   };
  // }

  async successChargeSavedPaymentMethod(
    transactionNumber: string,
  ): Promise<PaymentEntity> {
    Logger.log({ transactionNumber }, 'successChargeSavedPaymentMethod start');

    let payment = await this.paymentRepo.findOneByOrFail({
      transactionNumber: transactionNumber,
    });
    Logger.log({ payment }, 'successChargeSavedPaymentMethod found payment');

    const gateway = await this.gatewayToUserRepo.findOneOrFail({
      where: {
        internalUserId: `${payment.userType}_${payment.userId}`,
        gatewayId: payment.gatewayId,
      },
      relations: {
        gateway: true,
      },
    });
    Logger.log(
      { gateway: gateway.gateway },
      'successChargeSavedPaymentMethod found gateway',
    );

    // verify the payment status through stripe sdk
    const stripePayment = await this.verifyIntent(
      gateway.gateway,
      payment.externalReferenceNumber,
    );
    Logger.log(
      { stripePayment },
      'successChargeSavedPaymentMethod stripe verification result',
    );

    if (stripePayment.status === 'succeeded') {
      await this.paymentRepo.update(payment.id, {
        status: PaymentStatus.Success,
      });
      payment = await this.paymentRepo.findOneByOrFail({
        transactionNumber: transactionNumber,
      });
      return payment;
    } else if (stripePayment.status === 'requires_capture') {
      await this.paymentRepo.update(payment.id, {
        status: PaymentStatus.Authorized,
      });
      payment = await this.paymentRepo.findOneByOrFail({
        transactionNumber: transactionNumber,
      });
      return payment;
    } else if (stripePayment.status == 'canceled') {
      Logger.log(
        'successChargeSavedPaymentMethod updating payment status to Failed',
      );
      await this.paymentRepo.update(payment.id, {
        status: PaymentStatus.Failed,
      });
      payment = await this.paymentRepo.findOneByOrFail({
        transactionNumber: transactionNumber,
      });
      Logger.log(
        { updatedPayment: payment },
        'successChargeSavedPaymentMethod payment marked as failed',
      );
      return payment;
    } else {
      throw new Error(
        'An Unknown stripe state in stripeService.successChargeSavedPaymentMethod',
      );
    }
  }

  async getPayoutLinkUrl(input: {
    method: PayoutMethodEntity;
    userType: string;
    userId: number;
    returnUrl: string;
  }) {
    const instance = new Stripe(input.method.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    let account: Stripe.Account;
    try {
      account = await instance.accounts.retrieve(input.userId.toString());
    } catch (error) {
      account = await instance.accounts.create({
        type: 'express',
        capabilities: {
          transfers: {
            requested: true,
          },
        },
        metadata: {
          userId: input.userId.toString(),
          userType: input.userType,
          return_url: input.returnUrl,
        },
        business_type: 'individual',
        // individual: {
        //   first_name: 'john',
        //   last_name: 'doe',
        //   phone: '+16505551234',
        //   address: {
        //     line1: 'address_full_match',
        //     city: 'city_full_match',
        //     state: 'state_full_match',
        //     postal_code: 'postal_code_full_match',
        //   },

        //   dob: {
        //     day: 1,
        //     month: 1,
        //     year: 1901,
        //   },
        //   id_number: '000000000',
        //   verification: {
        //     document: {
        //       front: 'file_identity_document_success',
        //     },
        //   },
        // },
      });
    }
    Logger.log(account, 'stripeService.getPayoutLinkUrl.account');
    const link = await instance.accountLinks.create({
      account: account.id,
      refresh_url: `${process.env.GATEWAY_SERVER_URL}/stripe/payout/refresh`,
      return_url: `${process.env.GATEWAY_SERVER_URL}/stripe/payout/return?account_id=${account.id}&payout_method_id=${input.method.id}`,
      type: 'account_onboarding',
    });
    Logger.log(link, 'stripeService.getPayoutLinkUrl.link');
    return link.url;
  }

  async verify(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<Stripe.Checkout.Session> {
    const instance = new Stripe(paymentGateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    const response =
      await instance.checkout.sessions.retrieve(transactionNumber);
    return response;
  }

  async verifyIntent(
    paymentGateway: PaymentGatewayEntity,
    transactionNumber: string,
  ): Promise<Stripe.PaymentIntent> {
    const instance = new Stripe(paymentGateway.privateKey!, {
      apiVersion: '2025-07-30.basil',
    });
    const response = await instance.paymentIntents.retrieve(transactionNumber);
    return response;
  }
}
