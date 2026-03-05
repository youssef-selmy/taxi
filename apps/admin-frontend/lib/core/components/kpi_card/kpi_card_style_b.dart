import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';

class KPICardStyleB extends StatelessWidget {
  final String title;
  final String value;
  final Either<IconData, String>? icon;
  final Widget? subtitle;
  final String? currency;
  final NumberCardTitleStyle titleStyle;

  const KPICardStyleB({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.subtitle,
    this.currency,
    this.titleStyle = NumberCardTitleStyle.regular,
  });

  @override
  Widget build(BuildContext context) {
    return AppClickableCard(
      padding: const EdgeInsets.all(16),
      type: ClickableCardType.elevated,
      elevation: BetterShadow.shadow8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: _titleStyle(context)),
          const SizedBox(height: 8),
          Row(
            children: [
              if (icon != null) ...[_icon(context), const SizedBox(width: 8)],
              Text(value, style: context.textTheme.labelLarge),
            ],
          ),
          const SizedBox(height: 8),
          if (subtitle != null) subtitle!,
        ],
      ),
    );
  }

  Widget _icon(BuildContext context) {
    return icon!.fold(
      (icon) => Icon(icon, color: context.colors.primary),
      (url) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: CachedNetworkImage(
          imageUrl: url,
          width: 32,
          height: 32,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  TextStyle _titleStyle(BuildContext context) {
    return switch (titleStyle) {
      NumberCardTitleStyle.regular => context.textTheme.labelLarge,
      NumberCardTitleStyle.variant => context.textTheme.labelLarge?.variant(
        context,
      ),
    }!;
  }
}

enum NumberCardTitleStyle { regular, variant }
