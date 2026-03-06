import 'package:api_response/api_response.dart';
import 'package:better_design_system/molecules/file_upload/file_upload.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFileUpload)
Widget fileUploadWidgetUseCase(BuildContext context) {
  final title = context.knobs.stringOrNull(
    label: 'Title (Optional)',
    initialValue: 'Upload image',
    description: 'The optional main title text displayed (detailed mode only).',
  );

  final subtitle = context.knobs.stringOrNull(
    label: 'Subtitle (Optional)',
    initialValue: 'JPG or PNG, max 2MB',
    description: 'The optional secondary text displayed (detailed mode only).',
  );

  final imageUrl = context.knobs.string(
    label: 'Image URL (Optional)',
    initialValue: 'https://picsum.photos/id/237/200/200',
    description:
        'Provide a valid image URL to see the Uploaded state. Set to null for Empty state.',
  );

  // final isLoading = context.knobs.boolean(
  //   label: 'Loading State?',
  //   initialValue: false,
  //   description:
  //       'Simulates the loading state of the widget (disables all buttons).',
  // );
  final provideOnChange = context.knobs.boolean(
    label: 'Provide onChange Callback?',
    initialValue: true,
    description:
        'Simulates providing the onChange callback (enables relevant buttons).',
  );
  final provideOnDelete = context.knobs.boolean(
    label: 'Provide onDelete Callback?',
    initialValue: true,
    description:
        'Simulates providing the onDelete callback (enables Delete button).',
  );

  final uploadFieldStyle = context.knobs.object.dropdown(
    label: 'Upload Field Style',
    options: UploadFieldStyle.values,
    initialOption: UploadFieldStyle.compact,
    labelBuilder: (value) => value.name,
    description: 'Select the style of the upload field.',
  );

  return AppFileUpload<String>(
    title: title,
    subtitle: subtitle,
    imageUrlGetter: (response) => response,
    initialValue: imageUrl,
    style: uploadFieldStyle,
    onUpload: (value, bytes) async {
      return ApiResponse.loaded('');
    },
    onSaved: provideOnChange ? (value) {} : null,
    onDelete: provideOnDelete ? (value) => true : null,
  );
}
