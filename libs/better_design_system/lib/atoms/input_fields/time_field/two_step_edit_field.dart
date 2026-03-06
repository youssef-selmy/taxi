// import 'package:better_design_system/colors/semantic_color.dart';
// import 'package:better_design_system/utils/extensions/extensions.dart';
// import 'package:flutter/material.dart';

// class AppTwoStepEditField extends StatefulWidget {
//   final String title;
//   final String? initialValue;
//   final String? hintText;
//   final Function(String) onConfirmChange;

//   const AppTwoStepEditField({
//     super.key,
//     required this.title,
//     required this.initialValue,
//     this.hintText,
//     required this.onConfirmChange,
//   });

//   @override
//   State<AppTwoStepEditField> createState() => _AppTwoStepEditFieldState();
// }

// class _AppTwoStepEditFieldState extends State<AppTwoStepEditField> {
//   bool isEditing = false;
//   FocusNode focusNode = FocusNode();
//   late TextEditingController controller;

//   @override
//   void initState() {
//     controller = TextEditingController(
//       text: widget.initialValue,
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           widget.title,
//           style: context.textTheme.labelMedium?.variant(context),
//         ),
//         Spacer(),
//         SizedBox(
//           width: 200,
//           child: TextField(
//             focusNode: focusNode,
//             controller: controller,
//             canRequestFocus: isEditing,
//             readOnly: !isEditing,
//             textAlign: TextAlign.end,
//             decoration: InputDecoration(
//               hintText: widget.hintText,
//               border: InputBorder.none,
//               enabledBorder: InputBorder.none,
//               isDense: true,
//             ),
//           ),
//         ),
//         if (!isEditing) ...[
//           const SizedBox(width: 8),
//           AppIconButton(
//             onPressed: () {
//               setState(() {
//                 isEditing = true;
//               });
//               WidgetsBinding.instance.addPostFrameCallback((_) => focusNode.requestFocus());
//             },
//             color: SemanticColor.grey,
//             icon: AppHugeIcons.editOutline,
//           ),
//         ],
//         if (isEditing) ...[
//           const SizedBox(width: 8),
//           AppIconButton(
//             onPressed: () {
//               setState(() {
//                 isEditing = false;
//               });
//               widget.onConfirmChange(controller.text);
//             },
//             color: SemanticColor.success,
//             icon: AppHugeIcons.checkOutline,
//           ),
//         ],
//       ],
//     );
//   }
// }
