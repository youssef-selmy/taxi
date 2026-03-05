import 'package:admin_frontend/core/graphql/fragments/email_provider.graphql.dart';

extension EmailProviderListItemX on Fragment$emailProviderListItem {
  int get emailsCount => emailsAggregate.firstOrNull?.count?.id ?? 0;
}
