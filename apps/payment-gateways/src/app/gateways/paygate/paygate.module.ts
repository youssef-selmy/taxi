import { HttpModule } from '@nestjs/axios';
import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PaymentGatewayEntity } from '../../database/payment-gateway.entity';
import { PaymentEntity } from '../../database/payment.entity';
import { PaymentModule } from '../../payment/payment.module';
import { PayGateController } from './paygate.controller';
import { PayGateService } from './paygate.service';

@Module({
  imports: [
    PaymentModule,
    TypeOrmModule.forFeature([PaymentEntity, PaymentGatewayEntity]),
  ],
  controllers: [PayGateController],
  providers: [PayGateService],
  exports: [PayGateService],
})
export class PayGateModule {}
