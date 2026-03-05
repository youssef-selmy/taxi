import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CryptoModule } from '../crypto/crypto.module';
import { PaymentEntity } from '../database/payment.entity';
import { PaymentService } from './payment.service';
import { PayoutMethodEntity } from '../database/payout-method.entity';
import { PayoutAccountEntity } from '../database/payout-account.entity';
import { PayoutService } from './payout.service';

@Module({
  imports: [
    CryptoModule,
    TypeOrmModule.forFeature([
      PaymentEntity,
      PayoutMethodEntity,
      PayoutAccountEntity,
    ]),
  ],
  providers: [PaymentService, PayoutService],
  exports: [PaymentService, PayoutService],
})
export class PaymentModule {}
