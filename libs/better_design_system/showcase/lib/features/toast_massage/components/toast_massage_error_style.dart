import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/toast/toast.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

import 'toast_message_preview.dart';

class ToastMassageErrorStyle extends StatelessWidget {
  const ToastMassageErrorStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastMassagePreview(
      toastMassage: SizedBox(
        width: 380,
        child: AppToast(
          title: 'Payment Failed',
          subtitle:
              'Transaction declined. Please check your status and try again.',
          toastStyle: ToastStyle.fill,
          size: ToastSize.large,
          onClosed: () {},
          color: SemanticColor.error,
          actions: [ToastAction(title: 'Try Again', onPressed: () {})],
        ),
      ),
      bottom: 0,
      right: 0,
    );
  }
}
