import { InjectRepository } from '@nestjs/typeorm';
import { PayoutMethodEntity } from '../../database/payout-method.entity';
import { Repository } from 'typeorm';
import { Injectable } from '@nestjs/common';

@Injectable()
export class StripePayoutService {
  constructor(
    @InjectRepository(PayoutMethodEntity)
    private readonly payoutMethodRepository: Repository<PayoutMethodEntity>,
  ) {}

  async getStripePayoutMethod(id: number): Promise<PayoutMethodEntity> {
    return await this.payoutMethodRepository.findOneOrFail({
      where: { id: id },
    });
  }
}
