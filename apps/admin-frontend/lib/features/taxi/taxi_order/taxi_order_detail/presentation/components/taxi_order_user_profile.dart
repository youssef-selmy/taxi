import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TaxiOrderUserProfile extends StatelessWidget {
  const TaxiOrderUserProfile({
    super.key,
    required this.title,
    required this.imgUrl,
    required this.name,
    required this.mobileNumber,
    this.countryCode,
  });

  final String title;
  final String? imgUrl;
  final String name;
  final String mobileNumber;

  final String? countryCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          imageUrl: imgUrl,
          size: AvatarSize.size40px,
          shape: AvatarShape.rounded,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 2,
            children: [
              Text(
                title,
                style: context.textTheme.labelSmall?.variant(context),
              ),
              Text(name, style: context.textTheme.labelLarge),
            ],
          ),
        ),
        AppIconButton(
          icon: BetterIcons.call02Filled,
          size: ButtonSize.medium,
          style: IconButtonStyle.outline,
          onPressed: () {
            launchUrlString('tel:+$mobileNumber');
          },
        ),
      ],
    );
  }
}
