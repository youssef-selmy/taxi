import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter/foundation.dart';

abstract class UploadDatasource {
  Future<ApiResponse<Fragment$Media>> uploadImage(
    String filePath, {
    Uint8List? fileBytes,
  });

  Stream<double> uploadImageWithProgress({
    required String filePath,
    required void Function(Fragment$Media media) onComplete,
    Uint8List? fileBytes,
  });

  Future<String> uploadFirebasePrivateKey(Uint8List fileBytes);
}
