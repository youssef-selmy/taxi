import { PaymentGatewayType } from '@ridy/database';
import { Column, Entity, OneToMany, PrimaryGeneratedColumn } from 'typeorm';
import { GatewayToUserEntity } from './gateway-to-user.entity';
import { SavedPaymentMethodEntity } from './saved-payment-method.entity';

@Entity('payment_gateway')
export class PaymentGatewayEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  title!: string;

  @Column('enum', {
    enum: PaymentGatewayType,
  })
  type!: PaymentGatewayType;

  @Column({
    nullable: true,
  })
  publicKey?: string;

  @Column()
  privateKey!: string;

  @Column({
    nullable: true,
  })
  merchantId?: string;

  @Column({ nullable: true })
  saltKey?: string;

  @OneToMany(
    () => GatewayToUserEntity,
    (gatewayToUser) => gatewayToUser.gateway,
  )
  userIds?: GatewayToUserEntity[];

  @OneToMany(
    () => SavedPaymentMethodEntity,
    (savedPaymentMethod) => savedPaymentMethod.paymentGateway,
  )
  savedPaymentMethods!: SavedPaymentMethodEntity[];
}
