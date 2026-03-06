import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';

class MapSettingItem extends StatelessWidget {
  final AssetGenImage image;
  final String title;
  final bool isDisabled;
  final AppBadge? badge;
  final List<String> benefits;
  final List<String> shortComings;

  final bool isActive;
  final bool isSelected;
  final Function()? onPressed;

  const MapSettingItem({
    super.key,
    required this.image,
    required this.title,
    this.isDisabled = false,
    this.badge,
    required this.benefits,
    required this.shortComings,
    required this.isActive,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isDisabled ? null : onPressed,
      minimumSize: const Size(0, 0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isActive ? 1 : 0.9,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isActive ? 1 : 0.6,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.colors.outline, width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: image.image(fit: BoxFit.cover)),
                Container(
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    border: Border(
                      top: BorderSide(color: context.colors.outline, width: 1),
                    ),
                  ),
                  child: Column(
                    children: [
                      AppListItem(
                        title: title,
                        badge: badge,
                        isCompact: true,
                        padding: const EdgeInsets.all(16),
                        actionType: ListItemActionType.radio,
                        isSelected: isSelected,
                        isDisabled: isDisabled,
                        onTap: isDisabled ? null : (value) => onPressed?.call(),
                      ),
                      const AppDivider(height: 1),
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ...benefits.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      BetterIcons.checkmarkCircle02Filled,
                                      color: context.colors.success,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        e,
                                        style: context.textTheme.bodyMedium
                                            ?.variant(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ...shortComings.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Icon(
                                      BetterIcons.cancelCircleFilled,
                                      color: context.colors.error,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        e,
                                        style: context.textTheme.bodyMedium
                                            ?.variant(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
