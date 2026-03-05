import { PayTRService } from './paytr.service';
import * as DotEnv from 'dotenv';
import { PaymentGatewayType } from '@ridy/database';
import { HttpModule } from '@nestjs/axios';
import { Test } from '@nestjs/testing';
import { PaymentGatewayEntity } from '@ridy/database';

describe('PayTRController', () => {
  let service: PayTRService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule],
      providers: [PayTRService],
    }).compile();

    service = await moduleRef.resolve(PayTRService);
    DotEnv.config();
  });

  test('Should get payment link url', async () => {
    const gateway = new PaymentGatewayEntity();
    gateway.id = 1;
    gateway.title = 'PayTR';
    gateway.type = PaymentGatewayType.PayTR;
    gateway.privateKey = process.env.PAYTR_MERCHANT_KEY;
    gateway.merchantId = process.env.PAYTR_MERCHANT_ID;
    gateway.saltKey = process.env.PAYTR_SALT_KEY;

    const result = await service.getPaymentLink({
      gateway,
      userId: '1',
      userType: 'rider',
      currency: 'TR',
      amount: '200',
    });
    console.log(JSON.stringify(result));
    expect(result).toBeDefined();
    expect(result.url).not.toBeNull();
  });
});
