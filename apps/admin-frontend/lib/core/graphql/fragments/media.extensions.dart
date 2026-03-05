import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar_group.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:admin_frontend/core/graphql/fragments/media.fragment.graphql.dart';

export 'package:better_design_system/atoms/avatar/avatar_size.dart';

extension UrlStringX on String? {
  Widget widget({double width = 24, double height = 24}) {
    if (this == null) {
      return const SizedBox();
    }
    return CachedNetworkImage(
      imageUrl: this!,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  Widget roundedWidget({double size = 24, double? radius}) {
    if (this == null) {
      return const SizedBox();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? size / 2),
      child: CachedNetworkImage(
        imageUrl: this!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

extension MediaX on Fragment$Media? {
  Widget widget({double width = 24, double height = 24}) {
    if (this == null) {
      return const SizedBox();
    }
    return CachedNetworkImage(
      imageUrl: this!.address,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Icon(Icons.error, size: width),
    );
  }

  Widget roundedWidget({double size = 24, double? radius}) {
    if (this == null) {
      return const SizedBox();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? size / 2),
      child: CachedNetworkImage(
        imageUrl: this!.address,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}

extension MediaListX on List<Fragment$Media?> {
  Widget avatarsView({
    required BuildContext context,
    int? totalCount,
    AvatarGroupSize size = AvatarGroupSize.medium,
  }) {
    return AppAvatarGroup(
      avatars: nonNulls.map((media) => media.address).toList(),
      groupSize: size,
      isAvatarGroupBackgroundEnabled: false,
      totalAvatars: totalCount ?? nonNulls.length,
    );
    // const double overlapValue = 0.7;
    // return SizedBox(
    //   width: size * (length + ((totalCount != null && totalCount > length) ? 1 : 0) * 0.7) + 2,
    //   height: size + 2,
    //   child: Stack(
    //     children: [
    //       ...mapIndexed(
    //         (index, avatar) => Positioned(
    //           left: index * size * overlapValue,
    //           top: 0,
    //           child: Container(
    //             padding: const EdgeInsets.all(1),
    //             decoration: BoxDecoration(
    //               border: Border.all(color: context.colors.surface),
    //               shape: BoxShape.circle,
    //             ),
    //             child: AppAvatar(
    //               imageUrl: avatar?.address,
    //               size: size,
    //             ),
    //           ),
    //         ),
    //       ),
    //       if (totalCount != null && totalCount > length) ...[
    //         Positioned(
    //           left: length * size * overlapValue,
    //           child: Container(
    //             width: size,
    //             height: size,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: context.colors.surfaceVariant,
    //               border: Border.all(
    //                 color: context.colors.surface,
    //               ),
    //             ),
    //             child: Center(
    //               child: Text(
    //                 "+${totalCount - length}",
    //                 style: context.textTheme.labelMedium,
    //               ),
    //             ),
    //           ),
    //         )
    //       ]
    //     ],
    //   ),
    // );
  }
}

extension StringMediaX on String {
  Fragment$Media get toMedia => Fragment$Media(id: this, address: this);
}
