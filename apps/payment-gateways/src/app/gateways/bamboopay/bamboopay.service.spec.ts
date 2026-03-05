import { Test } from '@nestjs/testing';
import { BambooPayService } from './bamboopay.service';
import * as DotEnv from 'dotenv';
import { HttpModule } from '@nestjs/axios';
import { PaymentGatewayType } from '@ridy/database';
import { ConfigModule } from '@nestjs/config';
describe('Bamboopay', () => {
  let service: BambooPayService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule, ConfigModule.forRoot()],
      providers: [BambooPayService],
    }).compile();

    service = moduleRef.get<BambooPayService>(BambooPayService);
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'BambooPay',
          type: PaymentGatewayType.BambooPay,
          privateKey: process.env.BAMBOOPAY_PRIVATE_KEY,
          savedPaymentMethods: [],
        },
        userId: '1',
        userType: 'rider',
        userPhone: '08123456789',
        currency: 'NGN',
        amount: '200',
      });
      expect(result).toBeDefined();
      expect(result.url).not.toBeNull();
    });
  });
});
