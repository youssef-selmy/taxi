import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/item.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';

class AppDropDownStatusOverlay<T> extends StatelessWidget {
  final List<DropDownStatusItem<T>> items;
  final T? selectedValue;
  final void Function(T)? onChanged;

  const AppDropDownStatusOverlay({
    super.key,
    required this.items,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.outline),
        boxShadow: kShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...items.map(
            (e) => CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                onChanged?.call(e.value);
              },
              minimumSize: Size(0, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: e.chipType.containerColor(context),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (e.icon != null) ...[
                      Icon(e.icon, size: 16, color: e.chipType.main(context)),
                      const SizedBox(width: 4),
                    ],
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -1),
                        child: Text(
                          e.text,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: e.chipType.main(context),
                            letterSpacing: 0.25,
                          ),
                        ),
                      ),
                    ),
                    selectedValue == e.value
                        ? Icon(
                            BetterIcons.tick02Filled,
                            size: 16,
                            color: e.chipType.main(context),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              // child: AppTag(
              //   text: e.text,
              //   type: e.chipType,
              //   trailing: selectedValue == e.value
              //       ? const Icon(
              //           BetterIcons.tick02Filled,
              //           size: 16,
              //         )
              //       : null,
              // ),
            ),
          ),
        ].separated(separator: const SizedBox(height: 4)),
      ),
    );
  }
}
