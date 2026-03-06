import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/templates/profile_screen_template/profile_screen_template.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/organisms/expanded_profile_header/kpi_item.dart';

typedef BetterExpandedProfileHeader = AppExpandedProfileHeader;

class AppExpandedProfileHeader extends StatelessWidget {
  final String? avatarUrl;
  final String? title;
  final String? subtitle;
  final bool isTitleMuted;
  final List<KpiItem> kpiItems;
  final ProfileHeaderBackgroundType headerBackgroundType;

  const AppExpandedProfileHeader({
    super.key,
    this.avatarUrl,
    this.title,
    this.subtitle,
    this.isTitleMuted = false,
    this.kpiItems = const [],
    required this.headerBackgroundType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:
            headerBackgroundType == ProfileHeaderBackgroundType.roundedCircles
            ? DecorationImage(
                image: Assets.images.shapes.headerBackground.provider(),
                fit: BoxFit.fitWidth,
                opacity: 1,
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              AppAvatar(
                imageUrl: avatarUrl,
                size: AvatarSize.size72px,
                shape: AvatarShape.circle,
              ),
              const SizedBox(height: 16),
              Text(
                title ?? context.strings.guest,
                style: !isTitleMuted
                    ? context.textTheme.titleMedium
                    : context.textTheme.titleMedium?.variant(context),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
              ],
              if (kpiItems.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildKpiItems(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKpiItems(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            [
              for (var item in kpiItems)
                Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(
                    minWidth: context.isMobile ? 100 : 200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.title,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(item.icon, color: item.iconColor.main(context)),
                          const SizedBox(width: 10),
                          Text(
                            item.value.toString(),
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ].separated(
              separator: Container(
                width: 1,
                height: 50,
                color: context.colors.outline,
              ),
            ),
      ),
    );
  }
}
