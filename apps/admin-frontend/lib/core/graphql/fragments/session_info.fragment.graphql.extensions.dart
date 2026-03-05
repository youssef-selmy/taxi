import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/session_device/session_device.dart';
import 'package:admin_frontend/core/enums/device_platform_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.mock.dart';

extension SessionInfoFragmentX on Fragment$sessionInfo {
  Widget view(BuildContext context, Function() onTerminate) => SessionDevice(
    platformName: devicePlatform.name(context),
    location: ipLocation ?? "",
    platform: devicePlatform,
    lastUsed: lastActivityAt,
    onTerminate: onTerminate,
  );

  bool get isOnline =>
      lastActivityAt != null &&
      lastActivityAt!.isAfter(
        DateTime.now().subtract(const Duration(minutes: 5)),
      );
}

extension SessionInfoIdRecordPairX on List<(String, Fragment$sessionInfo)> {
  List<(String, Fragment$sessionInfo)> get onlineSessions =>
      where((pair) => pair.$2.isOnline).toList();

  List<(String, Fragment$sessionInfo)> get offlineSessions =>
      where((pair) => !pair.$2.isOnline).toList();

  Widget view({
    required BuildContext context,
    required bool isLoading,
    required Function(String id) onTerminate,
  }) {
    if (!isLoading && isEmpty) {
      return AppEmptyState(
        image: Assets.images.emptyStates.userData,
        title: context.tr.noActiveSessions,
      );
    }
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      child: LayoutGrid(
        columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
        rowSizes: [auto, auto],
        rowGap: 24,
        columnGap: 24,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.tr.onlineSessions,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              if (isLoading) ...[mockSessionInfo1.view(context, () {})],
              if (isLoading == false)
                ...onlineSessions.map(
                  (pair) => pair.$2.view(context, () => onTerminate(pair.$1)),
                ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.tr.offlineSessions,
                style: context.textTheme.bodyMedium?.variant(context),
              ),
              const SizedBox(height: 8),
              if (isLoading) ...[
                mockSessionInfo1.view(context, () {}),
                mockSessionInfo1.view(context, () {}),
              ],
              if (isLoading == false)
                ...offlineSessions.map(
                  (pair) => pair.$2.view(context, () => onTerminate(pair.$1)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
