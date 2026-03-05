import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/dashboard/domain/repositories/dashboard_repository.dart';

@dev
@LazySingleton(as: DashboardRepository)
class DashboardRepositoryMock implements DashboardRepository {}
