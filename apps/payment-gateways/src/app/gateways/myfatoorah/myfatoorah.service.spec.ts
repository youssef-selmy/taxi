import { MyFatoorahService } from './myfatoorah.service';
import * as DotEnv from 'dotenv';
import { HttpModule, HttpService } from '@nestjs/axios';
import { PaymentGatewayType } from '@ridy/database';
import { Test } from '@nestjs/testing';

describe('MyFatoorah', () => {
  let service: MyFatoorahService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule],
      providers: [MyFatoorahService],
    }).compile();
    service = moduleRef.get<MyFatoorahService>(MyFatoorahService);
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'MercadoPago',
          type: PaymentGatewayType.MyFatoorah,
          merchantId: 'vm',
          privateKey: process.env.MYFATOORAH_PRIVATE_KEY,
        },
        userId: '1',
        userType: 'rider',
        currency: 'USD',
        amount: '200',
      });
      expect(result).toBeDefined();
      expect(result.url).not.toBeNull();
    });
  });
});
