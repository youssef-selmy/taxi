import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';

extension ProfileX on Fragment$profile {
  String get fullName => [(firstName ?? ''), (lastName ?? '')].join(' ').trim();
}
