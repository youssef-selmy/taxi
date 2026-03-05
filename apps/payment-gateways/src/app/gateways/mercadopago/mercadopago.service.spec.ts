import { MercadopagoService } from './mercadopago.service';
import * as DotEnv from 'dotenv';
import { PaymentGatewayType } from '@ridy/database';

describe('MercadoPago', () => {
  let service: MercadopagoService;

  beforeEach(() => {
    service = new MercadopagoService();
    DotEnv.config();
  });

  describe('getPaymentLink', () => {
    it('Should get payment link url', async () => {
      const result = await service.getPaymentLink({
        gateway: {
          id: 1,
          title: 'MercadoPago',
          type: PaymentGatewayType.MercadoPago,
          merchantId: process.env.MERCADOPAGO_PRIVATE_KEY,
          privateKey: process.env.MERCADOPAGO_PUBLIC_KEY,
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
