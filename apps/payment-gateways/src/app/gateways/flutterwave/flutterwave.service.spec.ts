import { Test, TestingModule } from '@nestjs/testing';
import { FlutterwaveService } from './flutterwave.service';
import * as DotEnv from 'dotenv';
import { HttpModule } from '@nestjs/axios';
import { PaymentGatewayType } from '@ridy/database';
import { ConfigModule } from '@nestjs/config';
describe('Flutterwave', () => {
  let service: FlutterwaveService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule, ConfigModule.forRoot()],
      providers: [FlutterwaveService],
    }).compile();

    service = moduleRef.get<FlutterwaveService>(FlutterwaveService);
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'InstaMojo',
          type: PaymentGatewayType.Flutterwave,
          privateKey: process.env.FLUTTERWAVE_PRIVATE_KEY,
        },
        userId: '1',
        userType: 'rider',
        currency: 'NGN',
        amount: '200',
      });
      expect(result).toBeDefined();
      expect(result.url).not.toBeNull();
    });
  });
});
