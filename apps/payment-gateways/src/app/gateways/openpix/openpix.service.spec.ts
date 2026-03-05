import { OpenPixService } from './openpix.service';
import * as DotEnv from 'dotenv';
import { PaymentGatewayType } from '@ridy/database';
import { HttpModule } from '@nestjs/axios';
import { Test } from '@nestjs/testing';

describe('OpenPixController', () => {
  let service: OpenPixService;

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [HttpModule],
      providers: [OpenPixService],
    }).compile();

    service = await moduleRef.resolve(OpenPixService);
    DotEnv.config();
  });

  test('Should get payment link url', async () => {
    const result = await service.getPaymentLink({
      gateway: {
        id: 1,
        title: 'OpenPix',
        type: PaymentGatewayType.OpenPix,
        privateKey: process.env.OPENPIX_APP_ID,
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
