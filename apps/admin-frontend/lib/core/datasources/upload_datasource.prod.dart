// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:typed_data';
import 'package:api_response/api_response.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/v7.dart';

@prod
@LazySingleton(as: UploadDatasource)
class UploadDatasourceImpl implements UploadDatasource {
  UploadDatasourceImpl();

  Future<ApiResponse<Fragment$Media>> _uploadFile(
    String serverUrl,
    String? authorizationToken,
    String filePath, {
    Uint8List? fileBytes,
  }) async {
    final dio = Dio();

    MultipartFile file;
    if (kIsWeb) {
      if (fileBytes == null) {
        throw ArgumentError('fileBytes must be provided for web uploads');
      }
      final fileName = '${UuidV7().generate()}.png';
      file = MultipartFile.fromBytes(fileBytes, filename: fileName);
    } else {
      final fileName = p.basename(filePath);
      file = await MultipartFile.fromFile(filePath, filename: fileName);
    }

    final formData = FormData.fromMap({'file': file});

    final headers = {
      'Accept': 'application/json',
      if (authorizationToken != null)
        'Authorization': 'Bearer $authorizationToken',
    };

    final response = await dio.post(
      serverUrl,
      data: formData,
      options: Options(headers: headers),
    );

    final json = response.data;
    return ApiResponse.loaded(
      Fragment$Media(id: json['id'], address: json['address']),
    );
  }

  @override
  Future<ApiResponse<Fragment$Media>> uploadImage(
    String filePath, {
    Uint8List? fileBytes,
  }) {
    String? token = locator<AuthBloc>().state.accessToken;
    final serverUrl = p.join(Env.apiBaseUrl, 'upload');
    return _uploadFile(serverUrl, token, filePath, fileBytes: fileBytes);
  }

  @override
  Future<String> uploadFirebasePrivateKey(Uint8List fileBytes) async {
    final dio = Dio();
    final token = locator<AuthBloc>().state.accessToken;
    final serverUrl = p.join(Env.apiBaseUrl, 'config/upload');

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes, filename: 'firebase-key.json'),
    });

    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };

    final response = await dio.post(
      serverUrl,
      data: formData,
      options: Options(headers: headers),
    );

    final json = response.data;
    return json['address'];
  }

  @override
  Stream<double> uploadImageWithProgress({
    required String filePath,
    required void Function(Fragment$Media media) onComplete,
    Uint8List? fileBytes,
  }) async* {
    final controller = StreamController<double>();
    final dio = Dio();
    final fileName = p.basename(filePath);
    String? token = locator<AuthBloc>().state.accessToken;
    final serverUrl = p.join(Env.apiBaseUrl, 'upload');

    MultipartFile file;
    if (kIsWeb) {
      if (fileBytes == null) {
        throw ArgumentError('fileBytes must be provided for web uploads');
      }
      file = MultipartFile.fromBytes(fileBytes, filename: fileName);
    } else {
      file = await MultipartFile.fromFile(filePath, filename: fileName);
    }

    final formData = FormData.fromMap({'file': file});

    final headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    unawaited(() async {
      try {
        final response = await dio.post(
          serverUrl,
          data: formData,
          options: Options(headers: headers),
          onSendProgress: (sent, total) {
            final percent = ((sent / total) * 100);
            controller.add(percent);
          },
        );

        final json = response.data;
        final media = Fragment$Media(id: json['id'], address: json['address']);
        onComplete(media);
        await controller.close();
      } catch (e) {
        controller.addError(e);
        await controller.close();
      }
    }());

    yield* controller.stream;
  }
}
