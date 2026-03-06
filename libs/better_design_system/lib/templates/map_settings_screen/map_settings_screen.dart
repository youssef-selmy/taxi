import 'dart:io';

import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:flutter/cupertino.dart';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:generic_map/generic_map.dart';

import 'package:better_design_system/templates/map_settings_screen/map_provider.extensions.dart';
import 'package:better_design_system/templates/map_settings_screen/map_settings_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';

typedef BetterMapSettingsScreen = AppMapSettingsScreen;

class AppMapSettingsScreen extends StatefulWidget {
  final MapProviderEnum mapProvider;
  final Function(MapProviderEnum) onMapProviderChanged;

  const AppMapSettingsScreen({
    super.key,
    required this.mapProvider,
    required this.onMapProviderChanged,
  });

  @override
  State<AppMapSettingsScreen> createState() => _AppMapSettingsScreenState();
}

class _AppMapSettingsScreenState extends State<AppMapSettingsScreen> {
  PageController pageController = PageController(viewportFraction: 0.8);

  int activeId = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      padding: EdgeInsets.symmetric(
        horizontal: context.responsive(0, xl: 24),
        vertical: context.responsive(0, xl: 24),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (newSelectedPage) {
                  setState(() {
                    activeId = newSelectedPage;
                  });
                },
                children: MapProviderEnum.values
                    .where((provider) => provider != MapProviderEnum.mapLibre)
                    .mapIndexed((index, provider) {
                      return MapSettingItem(
                        isActive: activeId == index,
                        isSelected: widget.mapProvider == provider,
                        image: provider.image,
                        title: provider.title,
                        isDisabled: _isOptionDisabled(provider),
                        benefits: provider.positivePoints,
                        shortComings: provider.negativePoints,
                        badge: _getUnavailableBadge(provider),
                        onPressed: () => widget.onMapProviderChanged(provider),
                      );
                    })
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isOptionDisabled(MapProviderEnum provider) => switch (provider) {
    MapProviderEnum.mapBox || MapProviderEnum.openStreetMaps => false,
    MapProviderEnum.googleMaps =>
      kIsWeb ? false : ((Platform.isIOS || Platform.isAndroid) ? false : true),
    MapProviderEnum.mapBoxSDK || MapProviderEnum.mapLibre =>
      kIsWeb ? true : ((Platform.isIOS || Platform.isAndroid) ? false : true),
  };

  AppBadge? _getUnavailableBadge(MapProviderEnum provider) =>
      switch (provider) {
        MapProviderEnum.mapBox || MapProviderEnum.openStreetMaps => null,
        MapProviderEnum.googleMaps =>
          kIsWeb
              ? null
              : ((Platform.isIOS || Platform.isAndroid)
                    ? null
                    : _desktopUnavailableBadge()),
        MapProviderEnum.mapLibre =>
          kIsWeb
              ? _webUnavailableBadge()
              : ((Platform.isIOS || Platform.isAndroid)
                    ? null
                    : _desktopUnavailableBadge()),
        MapProviderEnum.mapBoxSDK =>
          kIsWeb
              ? _webUnavailableBadge()
              : ((Platform.isIOS || Platform.isAndroid)
                    ? null
                    : _desktopUnavailableBadge()),
      };

  AppBadge _webUnavailableBadge() {
    return const AppBadge(
      text: 'Unavailable on Web',
      color: SemanticColor.warning,
      isRounded: true,
    );
  }

  AppBadge _desktopUnavailableBadge() {
    return const AppBadge(
      text: 'Unavailable on Desktop',
      color: SemanticColor.warning,
      isRounded: true,
    );
  }
}
