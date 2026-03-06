import 'dart:math';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

export 'avatar_size.dart';

typedef BetterSpacedAvatarGroup = AppSpacedAvatarGroup;

class AppSpacedAvatarGroup extends StatelessWidget {
  final List<String?> imageUrls;
  final int maxImages;
  final AvatarSize size;
  final AvatarShape shape;
  final int count;
  final double spacing;
  final AvatarPlaceholder placeholder;

  const AppSpacedAvatarGroup({
    super.key,
    required this.imageUrls,
    required this.maxImages,
    required this.size,
    this.shape = AvatarShape.rounded,
    required this.count,
    this.spacing = 8,
    this.placeholder = AvatarPlaceholder.none,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: spacing,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < min(imageUrls.length, maxImages); i++)
          AppAvatar(
            imageUrl: imageUrls[i],
            size: size,
            shape: shape,
            placeholder: placeholder,
          ),
        if (count > maxImages)
          Container(
            width: size.padding.left + size.padding.right + (size.iconSize * 2),
            height:
                size.padding.top + size.padding.bottom + (size.iconSize * 2),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: shape.borderRadius(size),
              border: Border.all(color: context.colors.onSurface, width: 1),
            ),
            child: Center(
              child: Text(
                '+${count - maxImages}',
                style: TextStyle(
                  color: context.colors.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
