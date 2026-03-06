import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/toast/toast.dart';
import 'package:better_design_system/colors/semantic_color.dart';
import 'package:flutter/material.dart';

import 'toast_message_preview.dart';

class ToastMassageNeutralStyle extends StatelessWidget {
  const ToastMassageNeutralStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastMassagePreview(
      toastMassage: SizedBox(
        width: 380,
        child: AppToast(
          title: 'Storage Capacity: %84',
          subtitle:
              'Clear up storage or update your plan for additional storage.',
          toastStyle: ToastStyle.fill,
          size: ToastSize.large,
          onClosed: () {},
          color: SemanticColor.neutral,
          actions: [ToastAction(title: 'Manage Storag', onPressed: () {})],
        ),
      ),
      bottom: 0,
      right: 0,
    );
  }
}
