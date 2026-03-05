import { PayoutMethodType } from '@ridy/database';
import {
  Column,
  DeleteDateColumn,
  Entity,
  JoinColumn,
  OneToMany,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PayoutAccountEntity } from './payout-account.entity';

@Entity('payout_method')
export class PayoutMethodEntity {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({
    default: true,
  })
  enabled!: boolean;

  @Column()
  name!: string;

  @Column()
  description!: string;

  @Column('enum', {
    enum: PayoutMethodType,
  })
  type!: PayoutMethodType;

  @Column({
    nullable: true,
    type: 'text',
  })
  publicKey?: string;

  @Column({
    type: 'text',
  })
  privateKey!: string;

  @Column({ nullable: true, type: 'text' })
  saltKey?: string;

  @Column({
    nullable: true,
    type: 'text',
  })
  merchantId?: string;

  @DeleteDateColumn()
  deletedAt?: Date;

  @OneToMany(
    () => PayoutAccountEntity,
    (payoutAccount) => payoutAccount.payoutMethod,
  )
  payoutAccounts?: PayoutAccountEntity[];
}
