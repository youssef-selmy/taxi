import {
  Column,
  CreateDateColumn,
  DeleteDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { PayoutMethodEntity } from './payout-method.entity';
import { SavedPaymentMethodType } from '@ridy/database';

@Entity('payout_account')
export class PayoutAccountEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  name!: string;

  @Column()
  driverId!: number;

  @ManyToOne(
    () => PayoutMethodEntity,
    (payoutMethod) => payoutMethod.payoutAccounts,
  )
  payoutMethod?: PayoutMethodEntity;

  @Column()
  payoutMethodId!: number;

  @Column({
    nullable: true,
  })
  token?: string;

  @Column('enum', {
    enum: SavedPaymentMethodType,
  })
  type!: SavedPaymentMethodType;

  @Column()
  last4!: string;

  @Column()
  currency!: string;

  @Column({
    nullable: true,
  })
  accountNumber?: string;

  @Column({
    nullable: true,
  })
  routingNumber?: string;

  @Column({
    nullable: true,
  })
  accountHolderName?: string;

  @Column({
    nullable: true,
  })
  bankName?: string;

  @Column({
    nullable: true,
  })
  branchName?: string;

  @Column({
    nullable: true,
  })
  accountHolderAddress?: string;

  @Column({
    nullable: true,
  })
  accountHolderCity?: string;

  @Column({
    nullable: true,
  })
  accountHolderState?: string;

  @Column({
    nullable: true,
  })
  accountHolderZip?: string;

  @Column({
    nullable: true,
  })
  accountHolderCountry?: string;

  @Column({
    nullable: true,
  })
  accountHolderPhone?: string;

  @Column({
    nullable: true,
  })
  accountHolderDateOfBirth?: Date;

  @Column({
    default: false,
  })
  isVerified!: boolean;

  @Column({
    default: false,
  })
  isDefault!: boolean;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;

  @DeleteDateColumn()
  deletedAt?: Date;
}
