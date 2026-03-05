import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/settings/features/settings_general/data/repositories/settings_general_repository.dart';

@dev
@LazySingleton(as: SettingsGeneralRepository)
class SettingsGeneralRepositoryMock implements SettingsGeneralRepository {}
