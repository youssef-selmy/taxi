import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { PaymentGatewayEntity } from './payment-gateway.entity';
import { SavedPaymentMethodType } from '@ridy/database';
import { ProviderBrand } from '@ridy/database';

@Entity('saved_payment_method')
export class SavedPaymentMethodEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  title!: string;

  @Column({
    default: false,
  })
  isDefault!: boolean;

  @Column('enum', {
    enum: SavedPaymentMethodType,
  })
  type!: SavedPaymentMethodType;

  @Column('enum', {
    enum: ProviderBrand,
    nullable: true,
  })
  providerBrand?: ProviderBrand;

  @Column({
    nullable: true,
  })
  expiryDate?: Date;

  @Column({
    nullable: true,
  })
  holderName?: string;

  @Column({
    nullable: true,
  })
  riderId?: number;

  @Column({
    nullable: true,
  })
  driverId?: number;

  @Column()
  token!: string;

  @ManyToOne(
    () => PaymentGatewayEntity,
    (gateway) => gateway.savedPaymentMethods,
  )
  paymentGateway?: PaymentGatewayEntity;

  @Column()
  paymentGatewayId!: number;
}
