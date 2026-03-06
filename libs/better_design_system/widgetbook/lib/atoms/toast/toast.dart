import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/toast/toast.dart';
import 'package:better_design_system/atoms/toast/toast_alignment.dart';
import 'package:better_design_system/atoms/toast/toast_scope.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'soft', type: AppToast)
Widget softAppToast(BuildContext context) {
  return _getAppToast(context);
}

@UseCase(name: 'outline', type: AppToast)
Widget outlineAppToast(BuildContext context) {
  return _getAppToast(context, style: ToastStyle.outline);
}

@UseCase(name: 'fill', type: AppToast)
Widget fillAppToast(BuildContext context) {
  return _getAppToast(context, style: ToastStyle.fill);
}

Widget _getAppToast(
  BuildContext context, {
  ToastStyle style = ToastStyle.soft,
}) {
  final size = context.knobs.object.dropdown<ToastSize>(
    label: 'size',
    options: ToastSize.values,
    initialOption: ToastSize.large,
    labelBuilder: (value) => value.name,
  );
  final title = context.knobs.string(label: 'title', initialValue: 'Title');
  final subtitle = context.knobs.string(
    label: 'subtitle',
    initialValue: 'Description here',
  );

  const colors = [
    SemanticColor.error,
    SemanticColor.info,
    SemanticColor.success,
    SemanticColor.warning,
    SemanticColor.primary,
  ];

  return SizedBox(
    width: 350,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children:
          colors
              .map(
                (color) => AppToast(
                  onClosed: () {},
                  color: color,
                  size: size,
                  title: title,
                  subtitle: subtitle,
                  toastStyle: style,
                  actions: [
                    ToastAction(onPressed: () {}, title: 'Link button'),
                    ToastAction(onPressed: () {}, title: 'Link button'),
                  ],
                ),
              )
              .toList(),
    ),
  );
}

@UseCase(name: 'overlay test', type: AppToast)
Widget toastOverlayTest(BuildContext context) {
  return ToastScope(
    alignment: context.knobs.object.dropdown(
      label: 'Alignment',
      options: ToastAlignment.values,
      initialOption: ToastAlignment.bottomCenter,
      labelBuilder: (value) => value.name,
    ),
    visibleToastsAmount: context.knobs.int.slider(
      label: 'Visible Toasts Amount',
      min: 1,
      max: 6,
      initialValue: 3,
    ),
    isExpanded: context.knobs.boolean(label: 'Expanded', initialValue: false),
    child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder:
                      (context) => AppOutlinedButton(
                        text: 'Show Toast',
                        onPressed: () {
                          final toast = ToastScope.of(context);

                          late Object id;
                          id = toast.show(
                            AppToast(
                              maxHeight: 100,
                              onClosed: () => toast.hide(id),
                              title: "Event has been created",
                              subtitle: DateTime.now().toString(),
                              color: SemanticColor.success,
                              size: ToastSize.large,
                              toastStyle: ToastStyle.outline,
                              actions: [
                                ToastAction(
                                  title: "Undo",
                                  onPressed: () => toast.hide(id),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
