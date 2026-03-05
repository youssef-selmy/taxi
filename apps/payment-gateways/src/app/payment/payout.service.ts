import { Inject, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { SavedPaymentMethodType } from '@ridy/database';
import { PayoutAccountEntity } from '@ridy/database';
import { Repository } from 'typeorm';

@Injectable()
export class PayoutService {
  constructor(
    @InjectRepository(PayoutAccountEntity)
    private readonly payoutAccountsRepository: Repository<PayoutAccountEntity>,
  ) {}

  async linkPayoutAccount(input: {
    driverId: number;
    payoutMethodId: number;
    token: string;
    name: string;
    type: SavedPaymentMethodType;
    last4: string;
    currency: string;
    accountNumber?: string;
    routingNumber?: string;
    accountHolderName?: string;
    bankName?: string;
    branchName?: string;
    accountHolderAddress?: string;
    accountHolderCity?: string;
    accountHolderState?: string;
    accountHolderZip?: string;
    accountHolderCountry?: string;
    accountHolderPhone?: string;
    accountHolderDateOfBirth?: Date;
  }): Promise<PayoutAccountEntity> {
    this.payoutAccountsRepository.update(
      {
        driverId: input.driverId,
      },
      {
        isDefault: false,
      },
    );
    const account = this.payoutAccountsRepository.create({
      ...input,
      isDefault: true,
    });
    await this.payoutAccountsRepository.save(account);
    return account;
  }
}
