import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/map_pin/rod_pin.dart';
import 'package:better_design_system/better_icons.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:better_design_system/molecules/location_card/location_card.dart';
import 'package:flutter/material.dart';
import 'package:better_localization/localizations.dart';

class ViewOnMapDialog extends StatelessWidget {
  final LatLng latLng;
  final String? title;
  final String? subtitle;

  const ViewOnMapDialog({
    super.key,
    required this.latLng,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreenBottomSheet,
      desktopDialogType: DialogType.dialog,
      title: title ?? context.tr.viewOnMap,
      icon: BetterIcons.mapsFilled,
      onClosePressed: () => Navigator.of(context).pop(),
      primaryButton: AppFilledButton(
        text: context.tr.ok,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      maxWidth: 800,
      child: Column(
        children: [
          SizedBox(
            height: 600,
            child: AppGenericMap(
              initialLocation: Place(latLng, subtitle ?? '', title ?? ''),
              markers: [
                AppRodPin.marker(id: title ?? 'marker', position: latLng),
              ],
              interactive: true,
            ),
          ),
          const SizedBox(height: 16),
          AppLocationCard(
            title: title ?? context.tr.location,
            address: subtitle,
            icon: BetterIcons.pinLocation03Filled,
          ),
        ],
      ),
    );
  }
}
