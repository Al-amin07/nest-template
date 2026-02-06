// AppModule
import { Module } from '@nestjs/common';

import { AuthModule } from './module/auth/auth.module';
import { PrismaModule } from './module/prisma/prisma.module';
import { SeederService } from './seed/seed.service';
import { TwilioModule } from './module/twilio/twilio.module';
import { MailModule } from './module/mail/mail.module';
import { ScheduleModule } from '@nestjs/schedule';
import { ConfigModule } from '@nestjs/config';
import { StripeModule } from './module/stripe/stripe.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true, // Makes ConfigService available everywhere
      envFilePath: '.env', // Ensure this points to your file
    }),
    AuthModule,
    PrismaModule,
    TwilioModule,
    MailModule,
    ScheduleModule.forRoot(),
    StripeModule,
  ],
  providers: [SeederService],
})
export class AppModule {}
