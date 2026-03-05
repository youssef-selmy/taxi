import { PaymentGatewayType } from '@ridy/database';
import { InstaMojoService } from './instamojo.service';
import * as DotEnv from 'dotenv';

describe('InstaMojo', () => {
  let service: InstaMojoService;

  beforeEach(() => {
    service = new InstaMojoService();
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'InstaMojo',
          type: PaymentGatewayType.Instamojo,
          merchantId: process.env.INSTAMOJO_PRIVATE_KEY,
          privateKey: process.env.INSTAMOJO_PUBLIC_KEY,
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
