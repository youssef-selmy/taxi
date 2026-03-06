import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FintechProfileScreen extends StatelessWidget {
  const FintechProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Center(
        child: Assets.images.emptyStates.empty2.image(width: 200, height: 200),
      ),
    );
  }
}
