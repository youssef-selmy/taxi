// import 'package:better_design_system/utils/extensions/extensions.dart';
// import 'package:flutter/material.dart';

// class AppSidebarItem<T> extends StatefulWidget {
//   final String title;
//   final IconData icon;
//   final bool isSelected;
//   final T? value;
//   final Function(T?) onPressed;

//   const AppSidebarItem({
//     super.key,
//     required this.title,
//     required this.icon,
//     required this.isSelected,
//     required this.value,
//     required this.onPressed,
//   });

//   @override
//   createState() => _AppSidebarItemState<T>();
// }

// class _AppSidebarItemState<T> extends State<AppSidebarItem<T>> {
//   bool isHover = false;
//   bool isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onHover: (value) => setState(() => isHover = value),
//       onTap: () => widget.onPressed(widget.value),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         decoration: BoxDecoration(
//           color:
//               (isHover || widget.isSelected)
//                   ? context.colors.primaryContainer
//                   : null,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               widget.icon,
//               color:
//                   (isHover || widget.isSelected)
//                       ? context.colors.primary
//                       : context.colors.onSurfaceVariantLow,
//               size: 24,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               widget.title,
//               style: context.textTheme.labelLarge?.copyWith(
//                 color:
//                     (isHover || widget.isSelected)
//                         ? context.colors.primary
//                         : context.colors.onSurfaceVariantLow,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
