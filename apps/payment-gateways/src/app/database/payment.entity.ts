import { Column, PrimaryGeneratedColumn } from 'typeorm';
import { Entity } from 'typeorm/decorator/entity/Entity';

export enum PaymentStatus {
  Processing = 'processing',
  Success = 'success',
  Canceled = 'canceled',
  Authorized = 'authorized',
  Failed = 'failed',
}

@Entity('payment')
export class PaymentEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column('enum', {
    enum: PaymentStatus,
    default: PaymentStatus.Processing,
  })
  status!: PaymentStatus;

  @Column('float', {
    default: '0.00',
    precision: 10,
    scale: 2,
  })
  amount!: number;

  @Column()
  currency!: string;

  @Column()
  transactionNumber!: string;

  @Column()
  userType!: string;

  @Column()
  userId!: string;

  @Column('int', {
    nullable: true,
  })
  gatewayId?: number;

  @Column('int', {
    nullable: true,
  })
  savedPaymentMethodId?: number;

  @Column()
  returnUrl!: string;

  @Column('text', { nullable: true })
  externalReferenceNumber?: string;

  @Column({ nullable: true })
  orderNumber?: string;
}
