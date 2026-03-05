import { Test } from '@nestjs/testing';
import { StripeService } from './stripe.service';
import { HttpModule } from '@nestjs/axios';
import * as DotEnv from 'dotenv';
import { TypeOrmModule, getRepositoryToken } from '@nestjs/typeorm';
import { GatewayToUserEntity } from '@ridy/database';
import { DataSource } from 'typeorm';
import { PaymentGatewayEntity } from '@ridy/database';
import Stripe from 'stripe';

describe('StripeService', () => {
  let stripeService: StripeService;
  const testCustomer = 'cus_OnBJVSG4o3j2SY';

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule],
      providers: [
        StripeService,
        {
          provide: getRepositoryToken(GatewayToUserEntity),
          useValue: gatewayRepositoryMock,
        },
      ],
    }).compile();
    stripeService = moduleRef.get<StripeService>(StripeService);
    DotEnv.config();
  });

  it('should create a customer', async () => {
    const customer = await stripeService.createCustomer({
      apiKey: process.env.STRIPE_PRIVATE_KEY,
      userType: 'driver',
      userId: '10',
    });
    expect(customer).toBeDefined();
    expect(customer.id).toBeDefined();
  });

  it('getCustomerPaymentMethods', async () => {
    const instance = new Stripe(process.env.STRIPE_PRIVATE_KEY);
    const paymentIntent = await instance.paymentIntents.create({
      amount: 1000,
      currency: 'usd',
      customer: testCustomer,
    });
    console.log(paymentIntent);
  }, 10000);

  //   it('should create a payment intent', async () => {
  //     const paymentIntent = await stripeService.createPaymentIntent({
  //       amount: 1000,
  //       currency: 'usd',
  //       customer: 'cus_testcustomerid',
  //     });

  //     expect(paymentIntent).toBeDefined();
  //     expect(paymentIntent.id).toBeDefined();
  //   });

  //   it('should charge a payment', async () => {
  //     const paymentIntent = await stripeService.createPaymentIntent({
  //       amount: 1000,
  //       currency: 'usd',
  //       customer: 'cus_testcustomerid',
  //     });

  //     const payment = await stripeService.chargePayment({
  //       paymentIntentId: paymentIntent.id,
  //       paymentMethodId: 'pm_card_visa',
  //     });

  //     expect(payment).toBeDefined();
  //     expect(payment.id).toBeDefined();
  //   });
});

export const gatewayRepositoryMock = jest.fn(() => ({
  insert: jest.fn(() => {
    1;
  }),
  findOneBy: jest.fn(() => {
    1;
  }),
}));

export type MockType<T> = {
  [P in keyof T]?: jest.Mock<{}>;
};
