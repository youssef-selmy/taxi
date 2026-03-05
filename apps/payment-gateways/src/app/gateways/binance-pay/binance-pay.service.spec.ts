import { Test, TestingModule } from '@nestjs/testing';
import { BinancePayService } from './binance-pay.service';
import * as DotEnv from 'dotenv';
import { HttpModule } from '@nestjs/axios';
import { PaymentGatewayType } from '@ridy/database';
import { ConfigModule } from '@nestjs/config';
import { createHmac } from 'crypto';
describe('Binance Pay', () => {
  let service: BinancePayService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule, ConfigModule.forRoot()],
      providers: [BinancePayService],
    }).compile();

    service = moduleRef.get<BinancePayService>(BinancePayService);
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'Binance',
          type: PaymentGatewayType.BinancePay,
          privateKey: process.env.BINANCE_PRIVATE_KEY,
          publicKey: process.env.BINANCE_PUBLIC_KEY,
        },
        userId: '1',
        userType: 'rider',
        currency: 'USD',
        amount: '1',
      });
      expect(result).toBeDefined();
      expect(result.url).not.toBeNull();
    });
  });
});
