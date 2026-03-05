import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_document.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';

part 'create_new_driver_documents.model.freezed.dart';

@freezed
sealed class CreateNewDriverDocumentsModel
    with _$CreateNewDriverDocumentsModel {
  factory CreateNewDriverDocumentsModel({
    List<Fragment$Media?>? driverDocumentsImage,
    List<DateTime?>? driverDocumentsExpireDateTime,
    List<Fragment$driverDocumentRetentionPolicy?>?
    driverDocumentsRetentionPolicy,
    List<bool>? driverDocumentsExpireDate,
  }) = _CreateNewDriverDocumentsModel;
}
