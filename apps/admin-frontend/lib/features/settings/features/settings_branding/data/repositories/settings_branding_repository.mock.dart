import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_branding/data/repositories/settings_branding_repository.dart';

@dev
@LazySingleton(as: SettingsBrandingRepository)
class SettingsBrandingRepositoryMock implements SettingsBrandingRepository {}
