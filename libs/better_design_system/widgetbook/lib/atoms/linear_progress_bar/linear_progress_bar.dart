import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/linear_progress_bar/linear_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppLinearProgressBar)
Widget defaultLinearProgressBar(BuildContext context) {
  return Column(
    spacing: 30,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          progress: 0,
          linearProgressBarStatus: LinearProgressBarStatus.pending,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          linearProgressBarStatus: LinearProgressBarStatus.uploading,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          linearProgressBarStatus: LinearProgressBarStatus.error,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          linearProgressBarStatus: LinearProgressBarStatus.success,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
    ],
  );
}

@UseCase(name: 'TopPosition', type: AppLinearProgressBar)
Widget linearProgressBarTopPosition(BuildContext context) {
  return _getLinearProgressBar(context);
}

@UseCase(name: 'RightPosition', type: AppLinearProgressBar)
Widget linearProgressBarRightPosition(BuildContext context) {
  return _getLinearProgressBar(
    context,
    position: LinearProgressBarNumberPosition.right,
  );
}

Column _getLinearProgressBar(
  BuildContext context, {
  LinearProgressBarNumberPosition position =
      LinearProgressBarNumberPosition.top,
}) {
  return Column(
    spacing: 30,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          label: 'Label',
          hasSubtitleIcon: context.knobs.boolean(
            label: 'SubTitle Icon',
            initialValue: true,
          ),
          subtitle: 'Insert text here to help users.',
          onCancelPressed: () {},
          progress: 0.0,
          showProgressNumber: context.knobs.boolean(
            label: 'Progress Number',
            initialValue: true,
          ),
          linearProgressBarStatus: LinearProgressBarStatus.pending,
          linearProgressBarNumberPosition: position,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
          color: context.knobs.object.dropdown(
            label: 'color',
            options: SemanticColor.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          label: 'Label',
          hasSubtitleIcon: context.knobs.boolean(
            label: 'SubTitle Icon',
            initialValue: true,
          ),
          subtitle: 'Insert text here to help users.',
          onCancelPressed: () {},
          progress: 0.3,
          showProgressNumber: context.knobs.boolean(
            label: 'Progress Number',
            initialValue: true,
          ),
          linearProgressBarStatus: LinearProgressBarStatus.uploading,
          color: context.knobs.object.dropdown(
            label: 'color',
            options: SemanticColor.values,
            labelBuilder: (value) => value.name,
          ),
          linearProgressBarNumberPosition: position,
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          label: 'Label',
          hasSubtitleIcon: context.knobs.boolean(
            label: 'SubTitle Icon',
            initialValue: true,
          ),
          subtitle: 'Insert text here to help users.',
          onCancelPressed: () {},
          progress: 0.5,
          showProgressNumber: context.knobs.boolean(
            label: 'Progress Number',
            initialValue: true,
          ),
          linearProgressBarNumberPosition: position,
          linearProgressBarStatus: LinearProgressBarStatus.error,
          color: context.knobs.object.dropdown(
            label: 'color',
            options: SemanticColor.values,
            labelBuilder: (value) => value.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
      SizedBox(
        width: 320,
        child: AppLinearProgressBar(
          label: 'Label',
          hasSubtitleIcon: context.knobs.boolean(
            label: 'SubTitle Icon',
            initialValue: true,
          ),
          subtitle: 'Insert text here to help users.',
          onCancelPressed: () {},
          progress: 1.0,
          showProgressNumber: context.knobs.boolean(
            label: 'Progress Number',
            initialValue: true,
          ),
          linearProgressBarNumberPosition: position,
          linearProgressBarStatus: LinearProgressBarStatus.success,
          color: context.knobs.object.dropdown(
            label: 'color',
            options: SemanticColor.values,
            labelBuilder: (value) => value.name,
          ),
          size: context.knobs.object.dropdown(
            label: 'size',
            options: LinearProgressBarSize.values,
            labelBuilder: (value) => value.name,
          ),
        ),
      ),
    ],
  );
}
