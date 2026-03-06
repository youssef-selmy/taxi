import 'dart:async';
import 'package:better_design_system/molecules/file_upload/file_upload_manager.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'File Upload Manager', type: AppFileUploadManager)
Widget fileUploadManagerUseCase(BuildContext context) {
  return Center(
    child: AppFileUploadManager(
      primaryMessage: context.knobs.string(
        label: 'Primary Message',
        initialValue: 'Click to upload or drag and drop',
      ),
      secondaryMessage: context.knobs.string(
        label: 'Secondary Message',
        initialValue: 'SVG, PNG, JPG or GIF (max. 800x400px)',
      ),
      buttonText: context.knobs.string(
        label: 'Button Text',
        initialValue: 'Upload Files',
      ),
      cancelButtonText: context.knobs.string(
        label: 'Cancel Button Text',
        initialValue: 'Cancel Upload',
      ),
      onUpload: (files) {
        // Simulate upload progress
        return _simulateUpload();
      },
      onCancel: () {
        debugPrint('Upload cancelled');
      },
      onCompleted: (files) {
        debugPrint('Upload completed: ${files.length} files');
      },
      onError: (error) {
        debugPrint('Upload error: $error');
      },
      allowedExtensions: ['jpg', 'png', 'gif', 'svg'],
      maxFileSizeBytes: 5 * 1024 * 1024, // 5MB
      allowMultiple: context.knobs.boolean(
        label: 'Allow Multiple',
        initialValue: false,
      ),
      isDisabled: context.knobs.boolean(
        label: 'Is Disabled',
        initialValue: false,
      ),
      style: context.knobs.object.dropdown(
        label: 'Style',
        options: UploadCardStyle.values,
        labelBuilder: (style) => style.name,
        initialOption: UploadCardStyle.outlined,
      ),
    ),
  );
}

/// Simulates file upload with progress updates
Stream<double> _simulateUpload() async* {
  for (int i = 0; i <= 100; i += 5) {
    await Future.delayed(const Duration(milliseconds: 100));
    yield i / 100.0;
  }
}
