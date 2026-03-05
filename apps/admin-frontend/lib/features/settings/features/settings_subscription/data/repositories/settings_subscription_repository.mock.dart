import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_subscription/data/repositories/settings_subscription_repository.dart';

@dev
@LazySingleton(as: SettingsSubscriptionRepository)
class SettingsSubscriptionRepositoryMock
    implements SettingsSubscriptionRepository {}
