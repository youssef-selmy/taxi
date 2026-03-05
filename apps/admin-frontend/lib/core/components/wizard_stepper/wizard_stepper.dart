// import 'package:flutter/material.dart';

// import 'package:collection/collection.dart';

// import 'package:admin_frontend/core/extensions/extensions.dart';

// class WizardStepper extends StatelessWidget {
//   final List<WizardStepperStep> steps;
//   final int currentStep;

//   const WizardStepper({
//     super.key,
//     required this.steps,
//     required this.currentStep,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: steps
//           .asMap()
//           .entries
//           .mapIndexed(
//             (index, entry) => Expanded(
//               child: WizardStepperStep(
//                 title: entry.value.title,
//                 subtitle: entry.value.subtitle,
//                 currentStep: currentStep,
//                 index: index,
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
// }

// class WizardStepperStep extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final int currentStep;
//   final int index;

//   const WizardStepperStep({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     this.currentStep = 0,
//     this.index = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 height: 1,
//                 color: (currentStep >= index)
//                     ? context.colors.primary
//                     : context.colors.outlineVariant,
//               ),
//             ),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: currentStep > index
//                     ? null
//                     : Border.all(
//                         color: (currentStep >= index)
//                             ? context.colors.primary
//                             : context.colors.outlineVariant,
//                         width: 1,
//                       ),
//               ),
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 200),
//                 child: switch (currentStep - index) {
//                   0 => Center(
//                       child: Container(
//                         width: 4,
//                         height: 4,
//                         decoration: BoxDecoration(
//                           color: context.colors.primary,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                   > 0 => Container(
//                       width: 22,
//                       height: 22,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: context.colors.primary,
//                       ),
//                       child: Icon(
//                         Icons.check,
//                         color: context.colors.onPrimary,
//                         size: 16,
//                       ),
//                     ),
//                   _ => const SizedBox(),
//                 },
//               ),
//               // child: AnimatedSwitcher(
//               //   duration: const Duration(milliseconds: 200),
//               //   child: (currentStep < index)
//               //       ? const SizedBox()
//               //       : (Center(
//               //           child: Container(
//               //             width: 4,
//               //             height: 4,
//               //             decoration: BoxDecoration(
//               //               color: context.colors.primary,
//               //               shape: BoxShape.circle,
//               //             ),
//               //           ),
//               //         )),
//               // ),
//             ),
//             Expanded(
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 height: 1,
//                 color: (currentStep >= index)
//                     ? context.colors.primary
//                     : context.colors.outlineVariant,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           title,
//           style: (currentStep == index)
//               ? context.textTheme.bodyMedium?.apply(
//                   color: context.colors.primary,
//                 )
//               : context.textTheme.bodyMedium,
//         ),
//         Text(
//           subtitle,
//           style: context.textTheme.labelMedium
//               ?.copyWith(color: context.colors.onSurfaceVariant),
//         ),
//       ],
//     );
//   }
// }
