import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

import 'toast_message_preview.dart';

class ToastMassageWarningStyle extends StatelessWidget {
  const ToastMassageWarningStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastMassagePreview(
      toastMassage: SizedBox(
        width: 380,
        child: AppToast(
          title: 'Oh no, something went wrong!',
          subtitle: 'There was an problem with your request',
          toastStyle: ToastStyle.soft,
          size: ToastSize.large,
          onClosed: () {},
          color: SemanticColor.warning,
        ),
      ),
      bottom: 0,
      alignment: AlignmentGeometry.bottomCenter,
    );
  }
}
