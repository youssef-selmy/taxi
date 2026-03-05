// import 'package:flutter/material.dart';

// import 'package:better_design_system/atoms/radio/radio.dart';

// import 'package:admin_frontend/config/theme/shadows.dart';
// import 'package:admin_frontend/core/extensions/extensions.dart';

// class AppSelectableListTile<T> extends StatefulWidget {
//   final Widget title;
//   final Widget? subtitle;
//   final Widget? trailing;
//   final Widget? leading;
//   final bool isSelected;
//   final void Function(T)? onSelected;
//   final T value;
//   final bool showCheckbox;
//   final EdgeInsets padding;
//   final bool hasShadow;

//   const AppSelectableListTile({
//     super.key,
//     required this.title,
//     this.subtitle,
//     required this.isSelected,
//     this.onSelected,
//     required this.value,
//     this.trailing,
//     this.showCheckbox = true,
//     this.leading,
//     this.padding = const EdgeInsets.all(16),
//     this.hasShadow = true,
//   });

//   @override
//   State<AppSelectableListTile<T>> createState() =>
//       _AppSelectableListTileState<T>();
// }

// class _AppSelectableListTileState<T> extends State<AppSelectableListTile<T>> {
//   bool isHovered = false;
//   bool isPressed = false;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       overlayColor: const WidgetStatePropertyAll(Colors.transparent),
//       highlightColor: Colors.transparent,
//       focusColor: Colors.transparent,
//       hoverColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       splashFactory: NoSplash.splashFactory,
//       onHover: (value) => setState(() => isHovered = value),
//       onTapCancel: () => setState(() => isPressed = false),
//       onTapDown: (_) => setState(() => isPressed = true),
//       onTapUp: (_) => setState(() => isPressed = false),
//       onTap: () {
//         widget.onSelected?.call(widget.value);
//       },
//       child: AnimatedContainer(
//         duration: kThemeAnimationDuration,
//         padding: widget.padding,
//         decoration: BoxDecoration(
//           color: (widget.isSelected || isPressed)
//               ? context.colors.primaryContainer
//               : context.colors.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: borderColor(context),
//           ),
//           boxShadow: (widget.isSelected || !widget.hasShadow)
//               ? []
//               : kElevation1(context),
//         ),
//         child: Row(
//           children: [
//             if (widget.trailing != null) widget.trailing!,
//             if (widget.showCheckbox)
//               AppRadio(
//                 value: widget.isSelected,
//                 groupValue: true,
//               ),
//             if (widget.leading != null) ...[
//               widget.leading!,
//             ],
//             const SizedBox(
//               width: 8,
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   widget.title,
//                   if (widget.subtitle != null) ...[
//                     widget.subtitle!,
//                   ],
//                 ],
//               ),
//             ),
//             if (widget.trailing != null) ...[
//               widget.trailing!,
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Color borderColor(BuildContext context) {
//     if (widget.isSelected || isPressed) {
//       return context.colors.primary;
//     }
//     if (isHovered) {
//       return (context.colors.primary as MaterialColor).shade200;
//     }
//     return context.colors.outline;
//   }
// }
