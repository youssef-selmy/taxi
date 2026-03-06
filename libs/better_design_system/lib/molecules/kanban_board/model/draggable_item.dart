import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';

class DraggableItem<S> {
  final S columnIndex;
  final CardItem item;

  DraggableItem({required this.columnIndex, required this.item});
}
