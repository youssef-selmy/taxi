import 'package:better_design_system/atoms/accordion/accordion.dart';
import 'package:flutter/material.dart';

class AccordionListFirst extends StatelessWidget {
  const AccordionListFirst({super.key});

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
              title: 'How does Better Suite works?',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: false,
            ),
            AppAccordion(
              title: 'How can I update my subscription?',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: true,
            ),
            AppAccordion(
              title: 'How can I add new services?',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              initiallyExpanded: false,
            ),
            AppAccordion(
              title: 'How can I contact the support team?',
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
