import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

import 'package:admin_frontend/core/datasources/upload_datasource.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';

class UploadFieldLarge extends StatelessWidget {
  final UploadFieldType type;
  final Function(Fragment$Media)? onUploadImage;
  final Function(String)? onUploadFirebasePrivateKey;

  const UploadFieldLarge({
    super.key,
    required this.type,
    this.onUploadImage,
    this.onUploadFirebasePrivateKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropRegion(
          formats: type.formats,
          onDropOver: (value) async {
            return DropOperation.copy;
          },
          onPerformDrop: (value) async {
            final item = value.session.items.first;

            // data reader is available now
            final reader = item.dataReader!;
            if (reader.canProvide(Formats.json)) {
              reader.getFile(
                Formats.json,
                (value) async {
                  final data = await value.readAll();
                  // save file into temp directory
                  final tempDir = await getTemporaryDirectory();
                  File fileTemp = await File(
                    '${tempDir.path}/firebase_private_key.json',
                  ).create();
                  fileTemp.writeAsBytesSync(data);
                  final url = await locator<UploadDatasource>()
                      .uploadFirebasePrivateKey(data);
                  if (onUploadFirebasePrivateKey != null) {
                    onUploadFirebasePrivateKey!(url);
                  }
                },
                onError: (error) {
                  if (kDebugMode) {
                    print('Error reading value $error');
                  }
                },
              );
            }

            if (reader.canProvide(Formats.png) ||
                reader.canProvide(Formats.jpeg)) {
              reader.getFile(
                Formats.png,
                (file) async {
                  final data = await file.readAll();
                  // save file into temp directory
                  final tempDir = await getTemporaryDirectory();
                  File fileTemp = await File(
                    '${tempDir.path}/image.${file.fileName?.split('.').last}',
                  ).create();
                  fileTemp.writeAsBytesSync(data);
                  final media = await locator<UploadDatasource>().uploadImage(
                    '${tempDir.path}/image.${file.fileName?.split('.').last}',
                    fileBytes: data,
                  );
                  if (onUploadImage != null) {
                    onUploadImage!(media.data!);
                  }
                },
                onError: (error) {
                  if (kDebugMode) {
                    print('Error reading value $error');
                  }
                },
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.outline, width: 1.5),
            ),
            child: Column(
              children: [
                Icon(
                  BetterIcons.cloudUploadOutline,
                  size: 40,
                  color: context.colors.primary,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.tr.dropYourFileHereOr,
                      style: context.textTheme.titleLarge,
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                      onPressed: () async {
                        if (type == UploadFieldType.image) {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.image,
                            allowMultiple: false,
                            withData: true,
                          );
                          if (result != null) {
                            final uploadedImage =
                                await locator<UploadDatasource>().uploadImage(
                                  result.files.single.path!,
                                  fileBytes: result.files.single.bytes,
                                );
                            if (onUploadImage != null) {
                              onUploadImage!(uploadedImage.data!);
                            }
                          }
                        } else if (type == UploadFieldType.firebasePrivateKey) {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['json'],
                            allowMultiple: false,
                            withData: true,
                          );
                          if (result != null) {
                            final file = result.files.single;
                            if (file.path != null) {
                              final uploadedfile =
                                  await locator<UploadDatasource>()
                                      .uploadFirebasePrivateKey(
                                        result.files.single.bytes!,
                                      );
                              if (onUploadFirebasePrivateKey != null) {
                                onUploadFirebasePrivateKey!(uploadedfile);
                              }
                              // ignore: use_build_context_synchronously
                              context.showToast(context.tr.success);
                            }
                          }
                        }
                      },
                      child: Text(
                        context.tr.browse,
                        style: context.textTheme.titleMedium?.apply(
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${context.tr.supportedFormats}: ${type.supportedFormatsText}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum UploadFieldType { image, firebasePrivateKey }

extension UploadFieldTypeX on UploadFieldType {
  String title(BuildContext context) {
    switch (this) {
      case UploadFieldType.image:
        return context.tr.image;
      case UploadFieldType.firebasePrivateKey:
        return context.tr.firebasePrivateKey;
    }
  }

  String get supportedFormatsText {
    switch (this) {
      case UploadFieldType.image:
        return 'PNG, JPEG, GIF';
      case UploadFieldType.firebasePrivateKey:
        return 'JSON';
    }
  }

  List<DataFormat> get formats {
    switch (this) {
      case UploadFieldType.image:
        return [Formats.png, Formats.jpeg];
      case UploadFieldType.firebasePrivateKey:
        return [Formats.json];
    }
  }
}
