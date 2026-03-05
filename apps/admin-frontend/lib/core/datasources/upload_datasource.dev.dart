import 'package:api_response/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';

@dev
@LazySingleton(as: UploadDatasource)
class UploadDatasourceMock implements UploadDatasource {
  @override
  Future<ApiResponse<Fragment$Media>> uploadImage(
    String filePath, {
    Uint8List? fileBytes,
  }) async {
    return ApiResponse.loaded(ImageFaker().person.random().toMedia);
  }

  @override
  Future<String> uploadFirebasePrivateKey(Uint8List fileBytes) async {
    return "firebase_private_key.json";
  }

  @override
  Stream<double> uploadImageWithProgress({
    required String filePath,
    required void Function(Fragment$Media media) onComplete,
    Uint8List? fileBytes,
  }) async* {
    // Simulate upload progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: 100));
      yield i.toDouble();
    }

    // Call the onComplete callback with a fake media object
    onComplete(ImageFaker().person.random().toMedia);
  }
}
