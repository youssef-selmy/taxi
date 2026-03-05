import { Module } from '@nestjs/common';
import { PayTRService } from './paytr.service';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [HttpModule],
  providers: [PayTRService],
})
export class PayTRModule {}
