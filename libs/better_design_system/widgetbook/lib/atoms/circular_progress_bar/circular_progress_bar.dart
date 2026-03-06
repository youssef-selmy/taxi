import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/circular_progress_bar/circular_progress_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'circularProgressBar', type: AppCircularProgressBar)
Widget circularProgressBar(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 30,
    children: [
      AppCircularProgressBar(
        progress: 0.0,
        size: context.knobs.object.dropdown(
          label: 'size',
          options: CircularProgressBarSize.values,
          labelBuilder: (value) => value.name,
        ),
        color: context.knobs.object.dropdown(
          label: 'color',
          options: SemanticColor.values,
          labelBuilder: (value) => value.name,
        ),
        showProgressNumber: context.knobs.boolean(
          label: 'Progress Number',
          initialValue: true,
        ),
      ),
      AppCircularProgressBar(
        progress: 0.7,
        size: context.knobs.object.dropdown(
          label: 'size',
          options: CircularProgressBarSize.values,
          labelBuilder: (value) => value.name,
        ),
        color: context.knobs.object.dropdown(
          label: 'color',
          options: SemanticColor.values,
          labelBuilder: (value) => value.name,
        ),
        showProgressNumber: context.knobs.boolean(
          label: 'Progress Number',
          initialValue: true,
        ),
        status: CircularProgressBarStatus.uploading,
      ),
      AppCircularProgressBar(
        progress: 0.7,
        size: context.knobs.object.dropdown(
          label: 'size',
          options: CircularProgressBarSize.values,
          labelBuilder: (value) => value.name,
        ),
        color: context.knobs.object.dropdown(
          label: 'color',
          options: SemanticColor.values,
          labelBuilder: (value) => value.name,
        ),
        showProgressNumber: context.knobs.boolean(
          label: 'Progress Number',
          initialValue: true,
        ),
        status: CircularProgressBarStatus.error,
      ),
      AppCircularProgressBar(
        progress: 0.7,
        size: context.knobs.object.dropdown(
          label: 'size',
          options: CircularProgressBarSize.values,
          labelBuilder: (value) => value.name,
        ),
        color: context.knobs.object.dropdown(
          label: 'color',
          options: SemanticColor.values,
          labelBuilder: (value) => value.name,
        ),
        showProgressNumber: context.knobs.boolean(
          label: 'Progress Number',
          initialValue: true,
        ),
        status: CircularProgressBarStatus.uploading,
      ),
      AppCircularProgressBar(
        size: context.knobs.object.dropdown(
          label: 'size',
          options: CircularProgressBarSize.values,
          labelBuilder: (value) => value.name,
        ),
        color: context.knobs.object.dropdown(
          label: 'color',
          options: SemanticColor.values,
          labelBuilder: (value) => value.name,
        ),
        showProgressNumber: context.knobs.boolean(
          label: 'Progress Number',
          initialValue: true,
        ),
        progress: 1,
        status: CircularProgressBarStatus.success,
      ),
    ],
  );
}
