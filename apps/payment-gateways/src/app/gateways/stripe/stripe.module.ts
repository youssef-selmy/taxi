import { Module } from '@nestjs/common';
import { PaymentModule } from '../../payment/payment.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { StripeService } from './stripe.service';
import { StripeController } from './stripe.controller';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { GatewayToUserEntity } from '../../database/gateway-to-user.entity';
import { SavedPaymentMethodEntity } from '../../database/saved-payment-method.entity';
import { StripePayoutController } from './payout-controller';
import { PayoutAccountEntity } from '../../database/payout-account.entity';
import { PayoutMethodEntity } from '../../database/payout-method.entity';
import { StripePayoutService } from './payout-service';
import { PaymentEntity } from '../../database/payment.entity';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([
      PaymentGatewayEntity,
      GatewayToUserEntity,
      SavedPaymentMethodEntity,
      PayoutAccountEntity,
      PayoutMethodEntity,
      PaymentEntity,
    ]),
  ],
  providers: [StripeService, StripePayoutService],
  exports: [StripeService],
  controllers: [StripeController, StripePayoutController],
})
export class StripeModule {}
