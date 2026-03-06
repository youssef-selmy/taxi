import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinks {
  final String? instagramUrl;
  final String? youtubeUrl;
  final String? xUrl;
  final String? facebookUrl;
  final String? linkedInUrl;

  final Widget? custom1Icon;
  final String? custom1Url;

  final Widget? custom2Icon;
  final String? custom2Url;

  const SocialLinks({
    this.instagramUrl,
    this.youtubeUrl,
    this.xUrl,
    this.facebookUrl,
    this.linkedInUrl,
    this.custom1Icon,
    this.custom1Url,
    this.custom2Icon,
    this.custom2Url,
  });
}

extension AboutSocialLinksUI on SocialLinks {
  List<Widget> _items(BuildContext context) => [
    if (custom1Icon != null && custom1Url != null && custom1Url!.isNotEmpty)
      AppClickableCard(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () async {
          final uri = Uri.parse(custom1Url!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: custom1Icon!,
      ),
    if (custom2Icon != null && custom2Url != null && custom2Url!.isNotEmpty)
      AppClickableCard(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () async {
          final uri = Uri.parse(custom2Url!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: custom2Icon!,
      ),
    if (instagramUrl?.isNotEmpty ?? false)
      _SocialIcon(icon: Assets.images.brands.instagram, url: instagramUrl!),
    if (youtubeUrl?.isNotEmpty ?? false)
      _SocialIcon(icon: Assets.images.brands.youtube, url: youtubeUrl!),
    if (xUrl?.isNotEmpty ?? false)
      AppClickableCard(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        onTap: () async {
          final uri = Uri.parse(xUrl!);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Assets.images.brands.x.image(
          width: 20,
          height: 20,
          color: context.colors.onSurface,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    if (facebookUrl?.isNotEmpty ?? false)
      _SocialIcon(icon: Assets.images.brands.facebook, url: facebookUrl!),
    if (linkedInUrl?.isNotEmpty ?? false)
      _SocialIcon(icon: Assets.images.brands.linkedin, url: linkedInUrl!),
  ];

  Widget buildIcons(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: _items(context).toList(),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final AssetGenImage icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  Widget build(BuildContext context) {
    return AppClickableCard(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: icon.image(width: 20, height: 20),
    );
  }
}
