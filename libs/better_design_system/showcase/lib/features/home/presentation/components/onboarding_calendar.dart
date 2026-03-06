import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppOnboardingCalendar extends StatelessWidget {
  const AppOnboardingCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.isMobile
              ? const EdgeInsets.symmetric(horizontal: 16.0)
              : EdgeInsets.zero,
      child: AppClickableCard(
        padding: EdgeInsets.zero,
        type: ClickableCardType.elevated,
        elevation: BetterShadow.shadow4,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Onboarding Calendar',
                    style: context.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AppDatePicker(
                fullBleed: true,
                onChanged: (context) {},
                events: [
                  DateTime.now().subtract(const Duration(days: 6)),
                  DateTime.now().subtract(const Duration(days: 3)),
                  DateTime.now().add(const Duration(days: 2)),
                  DateTime.now().add(const Duration(days: 5)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
