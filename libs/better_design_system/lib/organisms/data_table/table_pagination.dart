import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'offset_page_info.dart';
import 'offset_paging.dart';

class TablePagination extends StatelessWidget {
  final OffsetPageInfo pageInfo;
  final OffsetPaging? paging;
  final Function(OffsetPaging) onPageChanged;

  const TablePagination({
    super.key,
    required this.pageInfo,
    required this.onPageChanged,
    required this.paging,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (pageInfo.hasPreviousPage ?? false) ...[
          AppOutlinedButton(
            color: SemanticColor.neutral,
            prefixIcon: BetterIcons.arrowLeft01Outline,
            onPressed: () {
              onPageChanged(
                OffsetPaging(
                  limit: paging?.limit ?? 10,
                  offset:
                      (paging?.offset ?? 10) - (paging?.limit ?? 10).toInt(),
                ),
              );
            },
            text: context.strings.previousPage,
          ),
        ],
        if (pageInfo.hasNextPage ?? false) ...[
          AppOutlinedButton(
            color: SemanticColor.neutral,
            suffixIcon: BetterIcons.arrowRight01Outline,
            onPressed: () {
              onPageChanged(
                OffsetPaging(
                  limit: paging?.limit ?? 10,
                  offset: (paging?.offset ?? 0) + (paging?.limit ?? 10).toInt(),
                ),
              );
            },
            text: context.strings.nextPage,
          ),
        ],
      ],
    );
  }
}
