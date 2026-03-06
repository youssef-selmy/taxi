import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';

class DropdownPhoneNumber extends StatefulWidget {
  const DropdownPhoneNumber({super.key});

  @override
  State<DropdownPhoneNumber> createState() => _DropdownPhoneNumberState();
}

class _DropdownPhoneNumberState extends State<DropdownPhoneNumber> {
  final OverlayPortalController controller = OverlayPortalController();
  final LayerLink layerLink = LayerLink();
  bool isExpanded = false;

  List<_CountryInformation> countries = [
    _CountryInformation(
      isSelected: true,
      flag: Assets.images.countries.unitedStates,
      name: 'United States',
      countryIso: '+1',
    ),
    _CountryInformation(
      isSelected: false,
      flag: Assets.images.countries.unitedKingdom,
      name: 'United Kindgom',
      countryIso: '+44',
    ),
    _CountryInformation(
      isSelected: false,
      flag: Assets.images.countries.spain,
      name: 'Spain',
      countryIso: '+34',
    ),
    _CountryInformation(
      isSelected: false,
      flag: Assets.images.countries.france,
      name: 'France',
      countryIso: '+33',
    ),
    _CountryInformation(
      isSelected: false,
      flag: Assets.images.countries.italy,
      name: 'Italy',
      countryIso: '+39',
    ),
  ];

  late _CountryInformation selectedCountry;
  @override
  void initState() {
    selectedCountry = countries.first;
    super.initState();
  }

  void selectCountry(_CountryInformation country) {
    setState(() {
      selectedCountry = country;
      isExpanded = false;
    });
    controller.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: 326,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: <Widget>[
            Text('Phone Number', style: context.textTheme.labelLarge),
            Row(
              children: [
                OverlayPortal(
                  controller: controller,
                  overlayChildBuilder: (context) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.hide();
                        setState(() {
                          isExpanded = false;
                        });
                      },
                      child: CompositedTransformFollower(
                        link: layerLink,
                        showWhenUnlinked: false,
                        offset: const Offset(0, 20),
                        followerAnchor: Alignment.topLeft,
                        targetAnchor: Alignment.bottomLeft,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 326,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.colors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: context.colors.outline),
                              boxShadow: [
                                BoxShadow(
                                  color: context.colors.shadow,
                                  offset: const Offset(0, 20),
                                  blurRadius: 40,
                                ),
                              ],
                            ),
                            child: Column(
                              spacing: 20,
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  countries.map((country) {
                                    return InkWell(
                                      onTap: () => selectCountry(country),
                                      child: Row(
                                        children: [
                                          AppRadio(
                                            value: country.countryIso,
                                            groupValue:
                                                selectedCountry.countryIso,
                                            onTap: null,
                                          ),
                                          const SizedBox(width: 8),
                                          country.flag.image(
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            country.name,
                                            style: context.textTheme.labelLarge,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            country.countryIso,
                                            style: context.textTheme.bodySmall
                                                ?.variant(context),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      controller.toggle();
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: CompositedTransformTarget(
                      link: layerLink,
                      child: Row(
                        children: [
                          selectedCountry.flag.image(width: 20, height: 20),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              Text(
                                selectedCountry.countryIso,
                                style: context.textTheme.labelMedium,
                              ),
                              AnimatedRotation(
                                duration: kThemeAnimationDuration,
                                turns: isExpanded ? 0.5 : 0,
                                child: Icon(
                                  BetterIcons.arrowDown01Outline,
                                  size: 22,
                                  color: context.colors.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppTextField(
                    hint: '--- --- ---',
                    isFilled: false,
                    density: TextFieldDensity.dense,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CountryInformation {
  final bool isSelected;
  final AssetGenImage flag;
  final String name;
  final String countryIso;

  _CountryInformation({
    required this.isSelected,
    required this.flag,
    required this.name,
    required this.countryIso,
  });
}
