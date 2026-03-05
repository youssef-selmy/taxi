import 'package:admin_frontend/core/graphql/fragments/mobile_number.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/personal_info.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockPersonalInfo1 = Fragment$personalInfo(
  firstName: 'John',
  lastName: 'Doe',
  email: '',
  mobileNumber: mockMobileNumber,
  gender: Enum$Gender.Male,
);

final mockPersonalInfo2 = Fragment$personalInfo(
  firstName: 'Jane',
  lastName: 'Doe',
  mobileNumber: mockMobileNumber,
  email: 'john@doe.com',
  gender: Enum$Gender.Male,
);
