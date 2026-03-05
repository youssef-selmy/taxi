import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/configurer/domain/repositories/configurer_repository.dart';

@dev
@LazySingleton(as: ConfigurerRepository)
class ConfigurerRepositoryMock implements ConfigurerRepository {}
