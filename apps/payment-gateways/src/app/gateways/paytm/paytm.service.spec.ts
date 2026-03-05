import { PaymentGatewayType } from '../../database/payment-gateway.entity';
import { PayTMService } from './paytm.service';
import * as DotEnv from "dotenv";
import { Test } from '@nestjs/testing';
import { HttpModule } from '@nestjs/axios';

describe('PayTM', () => {
    let service: PayTMService;

    beforeEach(async () => {
        const moduleRef = await Test.createTestingModule({
            imports: [HttpModule],
            providers: [PayTMService],
        }).compile();

        service = await moduleRef.resolve(PayTMService);
        DotEnv.config();
    });

    describe('getPaymentLink', () => {
        it('Should get payment link url', async () => {
            const result = await service.getPaymentLink({
                gateway: {
                    id: 1,
                    title: "PayTM",
                    type: PaymentGatewayType.Paytm,
                    merchantId: 'bLjcNk71218962826698',
                    privateKey: 'tT7X#S8ndQMhu4V6'
                    //merchantId: process.env.PAYTM_MERCHANT_ID,
                    //privateKey: process.env.PAYTM_MERCHANT_KEY
                },
                userId: '1',
                userType: 'rider',
                currency: "INR",
                amount: "200"
            });
            console.log(JSON.stringify(result));
            expect(result).toBeDefined();
            expect(result.url).not.toBeNull();
        });
    });
});