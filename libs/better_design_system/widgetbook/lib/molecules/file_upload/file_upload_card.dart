import 'package:better_design_system/molecules/file_upload/file_upload_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFileUploadCard)
Widget fileUploadAreaWidgetUseCase(BuildContext context) {
  final primaryMessage = context.knobs.string(
    label: 'Primary Message',
    initialValue: 'Drag & drop files to upload',
    description: 'The main message displayed in the upload area.',
  );

  final secondaryMessage = context.knobs.string(
    label: 'Secondary Message',
    initialValue: 'JPEG, PNG, PDF, and MP4 formats, up to 50 MB.',
    description: 'The secondary message with file specifications.',
  );

  final buttonText = context.knobs.string(
    label: 'Button Text',
    initialValue: 'Upload file',
    description: 'The text displayed on the upload button.',
  );

  final isDisabled = context.knobs.boolean(
    label: 'Disabled State',
    initialValue: false,
    description: 'Whether the component is disabled.',
  );

  final allowMultiple = context.knobs.boolean(
    label: 'Allow Multiple Files',
    initialValue: false,
    description: 'Whether multiple files can be selected.',
  );

  final style = context.knobs.object.dropdown(
    label: 'Upload Card Style',
    options: UploadCardStyle.values,
    labelBuilder: (style) => style.name,
    initialOption: UploadCardStyle.outlined,
    description: 'The visual style of the upload card.',
  );

  return AppFileUploadCard(
    primaryMessage: primaryMessage,
    secondaryMessage: secondaryMessage,
    buttonText: buttonText,
    isDisabled: isDisabled,
    allowMultiple: allowMultiple,
    style: style,
    allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf', 'mp4'],
    maxFileSizeBytes: 50 * 1024 * 1024, // 50 MB
    onFilesSelected: (List<PlatformFile> files) async {
      // Simulate upload delay
      await Future.delayed(const Duration(seconds: 2));

      // In a real implementation, this would upload the files
      debugPrint('Files selected: ${files.map((f) => f.name).join(', ')}');
    },
  );
}
