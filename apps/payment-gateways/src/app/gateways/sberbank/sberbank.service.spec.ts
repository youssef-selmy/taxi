import { SberBankService } from './sberbank.service';
import * as DotEnv from 'dotenv';
import { HttpModule, HttpService } from '@nestjs/axios';
import { PaymentGatewayType } from '@ridy/database';
import { Test } from '@nestjs/testing';

describe('SberBank', () => {
  let service: SberBankService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule],
      providers: [SberBankService],
    }).compile();
    service = moduleRef.get<SberBankService>(SberBankService);
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'MercadoPago',
          type: PaymentGatewayType.SberBank,
          publicKey: process.env.SBERBANK_USER,
          privateKey: process.env.SBERBANK_PASSWORD,
        },
        userId: '1',
        userType: 'rider',
        currency: 'USD',
        amount: '200',
      });
      expect(result).toBeDefined();
      expect(result.url).not.toBeNull();
    }, 60000);
  });
});
