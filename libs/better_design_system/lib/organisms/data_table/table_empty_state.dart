import 'package:better_assets/assets.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/cupertino.dart';

class TableEmptyState extends StatelessWidget {
  final String? message;
  final String? actionText;
  final Function()? onActionPressed;

  const TableEmptyState({
    super.key,
    this.message,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppEmptyState(
        image: Assets.images.emptyStates.cyberThreat,
        title: message ?? context.strings.noDataAvailable,
        actionText: actionText,
        onActionPressed: onActionPressed,
      ),
    );
  }
}
