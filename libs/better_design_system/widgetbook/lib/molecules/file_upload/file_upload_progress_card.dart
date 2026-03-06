import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar_status.dart';
import 'package:better_design_system/molecules/file_upload/file_upload_progress_card.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'File Upload Progress Card', type: AppFileUploadProgressCard)
Widget fileUploadProgressCardUseCase(BuildContext context) {
  return Center(
    child: AppFileUploadProgressCard(
      progress: context.knobs.double.slider(
        label: 'Progress',
        initialValue: 0.37,
        min: 0.0,
        max: 1.0,
      ),
      cancelButtonText: context.knobs.string(
        label: 'Cancel Button Text',
        initialValue: 'Cancel Upload',
      ),
      onCancel: () {
        // Handle cancel action
        debugPrint('Upload cancelled');
      },
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
      status: context.knobs.object.dropdown(
        label: 'Status',
        options: CircularProgressBarStatus.values,
        labelBuilder: (status) => status.name,
        initialOption: CircularProgressBarStatus.uploading,
      ),
    ),
  );
}
