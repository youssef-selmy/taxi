import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

import 'toast_message_preview.dart';

class ToastMassageSuccesstStyle extends StatelessWidget {
  const ToastMassageSuccesstStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastMassagePreview(
      toastMassage: SizedBox(
        width: 380,
        child: AppToast(
          title: 'Profile Updated',
          toastStyle: ToastStyle.outline,
          size: ToastSize.medium,
          onClosed: () {},
          color: SemanticColor.success,
        ),
      ),
      bottom: 0,
      right: 0,
    );
  }
}
