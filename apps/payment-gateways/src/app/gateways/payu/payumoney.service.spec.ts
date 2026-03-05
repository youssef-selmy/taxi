import { PaymentGatewayType } from '../../database/payment-gateway.entity';
import { PayUMoneyService } from './payumoney.service';
import * as DotEnv from "dotenv";

describe('PayUMoney', () => {
    let service: PayUMoneyService;

    beforeEach(() => {
        service = new PayUMoneyService();
        DotEnv.config();
    });

    describe('getPaymentLink', () => {
        it('Should get payment link url', async () => {
            const result = await service.getPaymentLink({
                gateway: {
                    id: 1,
                    title: "PayU",
                    type: PaymentGatewayType.PayU,
                    merchantId: process.env.RAZORPAY_KEY_ID,
                    privateKey: process.env.RAZORPAY_KEY_SECRET
                },
                userId: '1',
                userType: 'rider',
                currency: "INR",
                amount: "200"
            });
            expect(result).toBeDefined();
            expect(result.url).not.toBeNull();
        });
    });
});