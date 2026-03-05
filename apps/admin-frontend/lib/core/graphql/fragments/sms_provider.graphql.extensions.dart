import 'package:admin_frontend/core/graphql/fragments/sms_provider.graphql.dart';

extension SMSProviderListItemGQLX on Fragment$smsProviderListItem {
  int get messagesCount => messagesAggregate.firstOrNull?.count?.id ?? 0;
}
