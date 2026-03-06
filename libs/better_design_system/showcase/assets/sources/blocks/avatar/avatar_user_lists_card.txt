import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class AvatarUserListsCard extends StatelessWidget {
  const AvatarUserListsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 480,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User lists', style: context.textTheme.labelMedium),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvatar(
                    context,
                    imageUrl: ImageFaker().person.one,
                    name: 'Aspen Dokidis',
                    email: 'aspen@better.com',
                  ),
                  AppDivider(height: 20),
                  _buildAvatar(
                    context,
                    imageUrl: ImageFaker().person.two,
                    name: 'Phillip George',
                    email: 'philip@better.com',
                  ),
                  AppDivider(height: 20),
                  _buildAvatar(
                    context,
                    imageUrl: ImageFaker().person.three,
                    name: 'Miracle Press',
                    email: 'miracle@better.com',
                  ),
                  AppDivider(height: 20),
                  _buildAvatar(
                    context,
                    imageUrl: ImageFaker().person.four,
                    name: 'Martin Lubin',
                    email: 'martin@better.com',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context, {
    required String imageUrl,
    required String name,
    required String email,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        AppAvatar(imageUrl: imageUrl, size: AvatarSize.size40px),
        Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(name, style: context.textTheme.labelLarge),
            Text(email, style: context.textTheme.bodySmall?.variant(context)),
          ],
        ),
      ],
    );
  }
}
