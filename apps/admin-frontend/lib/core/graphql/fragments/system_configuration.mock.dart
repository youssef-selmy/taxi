import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/system_configuration.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockSystemConfiguration = Fragment$systemConfiguration(
  mysqlHost: "localhost",
  mysqlPort: 3306,
  mysqlDatabase: "admin",
  mysqlPassword: "admin",
  redisHost: "localhost",
  redisPort: 6379,
  redisDb: 0,
  redisPassword: "admin",
  adminPanelAPIKey: "AIzaSyDd8",
  backendMapsAPIKey: "AIzaSyDd8",
  firebaseProjectPrivateKey: "/path/to/private/key",
  taxi: Fragment$appConfigInfo(
    logo: ImageFaker().person.random(),
    name: "BetterTaxi",
    color: Enum$AppColorScheme.Cobalt,
  ),
);
