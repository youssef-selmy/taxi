import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/dot_badge/dot_badge.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:better_design_system/organisms/notification/notification.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

typedef BetterNotification2 = AppNotification2;

class AppNotification2 extends StatefulWidget {
  final String? title;
  final DateTime? date;
  final String? message;
  final String? quote;
  final String? actorAvatarUrl;
  final String? actorName;
  final StatusBadgeType? statusBadgeType;
  final String? badgeText;
  final SemanticColor badgeColor;
  final SemanticColor color;
  final String? primaryActionText;
  final String? secondaryActionText;
  final IconData? primaryActionIcon;
  final IconData? secondaryActionIcon;
  final Function()? primaryAction;
  final Function()? secondaryAction;
  final bool isUnread;
  final Function()? onTap;

  const AppNotification2({
    super.key,
    this.title,
    this.date,
    this.actorAvatarUrl,
    this.actorName,
    this.statusBadgeType,
    this.message,
    this.quote,
    this.badgeText,
    this.badgeColor = SemanticColor.warning,
    this.color = SemanticColor.primary,
    this.primaryActionText,
    this.primaryActionIcon,
    this.secondaryActionText,
    this.secondaryActionIcon,
    this.primaryAction,
    this.secondaryAction,
    this.isUnread = false,
    this.onTap,
  });

  @override
  State<AppNotification2> createState() => _AppNotification2State();
}

class _AppNotification2State extends State<AppNotification2> {
  // Tab values
  static const _viewAll = 'view_all';
  static const _mentions = 'mentions';

  late String _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = _viewAll; // initial option is View all
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(color: context.colors.outline),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: context.colors.shadow,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: context.textTheme.labelLarge,
                          ),
                        if (widget.badgeText != null) ...[
                          const SizedBox(width: 8),
                          AppBadge(
                            text: widget.badgeText!,
                            color: widget.badgeColor,
                            size: BadgeSize.small,
                          ),
                        ],
                      ],
                    ),
                  ),
                  Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.isUnread)
                        const BetterDotBadge(dotBadgeSize: DotBadgeSize.small),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 12, thickness: 1, color: context.colors.outline),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
              child: AppTabMenuHorizontal<String>(
                tabs: [
                  TabMenuHorizontalOption(title: 'View all', value: _viewAll),
                  TabMenuHorizontalOption(title: 'Mentions', value: _mentions),
                ],
                selectedValue: _selectedTab,
                onChanged: (val) {
                  setState(() => _selectedTab = val);
                },
                style: TabMenuHorizontalStyle.soft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppNotification(
                date: widget.date!,
                actorAvatarUrl: widget.actorAvatarUrl,
                actorName: widget.actorName,
                message: widget.message,
                quote: widget.quote,
                statusBadgeType: widget.statusBadgeType,
              ),
            ),
            Divider(height: 12, thickness: 1, color: context.colors.outline),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (widget.secondaryActionText != null)
                    AppTextButton(
                      color: widget.color,
                      size: ButtonSize.large,
                      prefixIcon: widget.secondaryActionIcon,
                      onPressed: widget.secondaryAction,
                      text: widget.secondaryActionText!,
                    ),
                  if (widget.primaryActionText != null)
                    AppFilledButton(
                      color: widget.color,
                      prefixIcon: widget.primaryActionIcon,
                      size: ButtonSize.large,
                      onPressed: widget.primaryAction,
                      text: widget.primaryActionText!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
