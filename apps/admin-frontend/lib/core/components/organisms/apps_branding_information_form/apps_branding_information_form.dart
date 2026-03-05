import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';

import 'package:admin_frontend/core/components/organisms/apps_branding_information_form/color_palette_dropdown.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AppsBrandingInformationForm extends StatelessWidget {
  final bool taxiEnabled;
  final bool shopEnabled;
  final bool parkingEnabled;
  final Fragment$Media? taxiLogo;
  final Function(Fragment$Media?) onTaxiLogoChanged;
  final String? taxiName;
  final Function(String?) onTaxiNameChanged;
  final Enum$AppColorScheme? taxiColorPalette;
  final Function(Enum$AppColorScheme?) onTaxiColorPaletteChanged;
  final Fragment$Media? shopLogo;
  final Function(Fragment$Media?) onShopLogoChanged;
  final String? shopName;
  final Function(String?) onShopNameChanged;
  final Enum$AppColorScheme? shopColorPalette;
  final Function(Enum$AppColorScheme?) onShopColorPaletteChanged;
  final Fragment$Media? parkingLogo;
  final Function(Fragment$Media?) onParkingLogoChanged;
  final String? parkingName;
  final Function(String?) onParkingNameChanged;
  final Enum$AppColorScheme? parkingColorPalette;
  final Function(Enum$AppColorScheme?) onParkingColorPaletteChanged;

  const AppsBrandingInformationForm({
    super.key,
    required this.taxiEnabled,
    required this.shopEnabled,
    required this.parkingEnabled,
    required this.taxiLogo,
    required this.taxiName,
    required this.taxiColorPalette,
    required this.shopLogo,
    required this.shopName,
    required this.shopColorPalette,
    required this.parkingLogo,
    required this.parkingName,
    required this.parkingColorPalette,
    required this.onTaxiLogoChanged,
    required this.onTaxiNameChanged,
    required this.onTaxiColorPaletteChanged,
    required this.onShopLogoChanged,
    required this.onShopNameChanged,
    required this.onShopColorPaletteChanged,
    required this.onParkingLogoChanged,
    required this.onParkingNameChanged,
    required this.onParkingColorPaletteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (taxiEnabled) ...[
          UploadFieldSmall(
            title: context.tr.taxiLogo,
            initialValue: taxiLogo,
            onChanged: onTaxiLogoChanged,
            validator: (p0) =>
                p0 == null ? context.tr.pleaseUploadValidTaxiLogo : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            isFilled: true,
            constraints: const BoxConstraints(maxWidth: 500),
            label: context.tr.taxiName,
            initialValue: taxiName,
            onChanged: onTaxiNameChanged,
            validator: (p0) => (p0?.isEmpty ?? true)
                ? context.tr.pleaseEnterValidTaxiName
                : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 500,
            child: ColorPaletteDropdown(
              onChanged: onTaxiColorPaletteChanged,
              initialValue: taxiColorPalette,
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (shopEnabled) ...[
          UploadFieldSmall(
            title: context.tr.shopLogo,
            initialValue: shopLogo,
            onChanged: onShopLogoChanged,
            validator: (p0) =>
                p0 == null ? context.tr.pleaseUploadValidShopLogo : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            isFilled: true,
            constraints: const BoxConstraints(maxWidth: 500),
            label: context.tr.shopName,
            initialValue: shopName,
            onChanged: onShopNameChanged,
            validator: (p0) => (p0?.isEmpty ?? true)
                ? context.tr.pleaseEnterValidShopName
                : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 500,
            child: ColorPaletteDropdown(
              initialValue: shopColorPalette,
              onChanged: onShopColorPaletteChanged,
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (parkingEnabled) ...[
          UploadFieldSmall(
            title: context.tr.parkingLogo,
            initialValue: parkingLogo,
            onChanged: onParkingLogoChanged,
            validator: (p0) =>
                p0 == null ? context.tr.pleaseUploadValidParkingLogo : null,
          ),
          const SizedBox(height: 16),
          AppTextField(
            isFilled: true,
            constraints: const BoxConstraints(maxWidth: 500),
            label: context.tr.parkingName,
            initialValue: parkingName,
            onChanged: onParkingNameChanged,
            validator: (p0) => (p0?.isEmpty ?? true)
                ? context.tr.pleaseEnterValidParkingName
                : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 500,
            child: ColorPaletteDropdown(
              initialValue: parkingColorPalette,
              onChanged: onParkingColorPaletteChanged,
            ),
          ),
          const SizedBox(height: 16),
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}
