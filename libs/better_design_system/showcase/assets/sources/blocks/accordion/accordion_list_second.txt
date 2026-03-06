import 'package:better_design_system/atoms/accordion/accordion.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class AccordionListSecond extends StatelessWidget {
  const AccordionListSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 8,
          children: <Widget>[
            AppAccordion(
              icon: BetterIcons.userCircle02Outline,
              title: 'Profile Information',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: false,
            ),
            AppAccordion(
              icon: BetterIcons.creditCardOutline,
              title: 'Payment Methods',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: true,
            ),
            AppAccordion(
              icon: BetterIcons.wallet01Outline,
              title: 'Wallet',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: false,
            ),
            AppAccordion(
              icon: BetterIcons.headphonesOutline,
              title: 'Support',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: false,
            ),
          ],
        ),
      ),
    );
  }
}
