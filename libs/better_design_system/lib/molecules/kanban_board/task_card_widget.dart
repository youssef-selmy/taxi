import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:better_design_system/molecules/kanban_board/model/draggable_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class ItemCard<S> extends StatelessWidget {
  final CardItem cardItem;
  final S columnIndex;

  const ItemCard({
    super.key,
    required this.cardItem,
    required this.columnIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: DraggableItem(columnIndex: columnIndex, item: cardItem),
      feedback: Opacity(
        opacity: 0.5,
        child: SizedBox(
          width: 320,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.colors.surface,
            ),
            child: cardItem.widget,
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.colors.surface,
          ),
          child: cardItem.widget,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.surface,
        ),
        child: cardItem.widget,
      ),
    );
  }
}
