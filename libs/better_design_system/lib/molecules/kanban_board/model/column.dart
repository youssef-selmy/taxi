import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:better_design_system/molecules/kanban_board/model/header.dart';

class KColumn<S> {
  final KColumnHeader header;
  final S value;
  final List<CardItem> children;

  KColumn({required this.header, required this.value, required this.children});
}
