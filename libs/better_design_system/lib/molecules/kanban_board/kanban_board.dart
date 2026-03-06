import 'package:better_design_system/molecules/kanban_board/model/column.dart';
import 'package:better_design_system/molecules/kanban_board/column_widget.dart';
import 'package:better_design_system/molecules/kanban_board/model/draggable_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

export 'package:better_design_system/molecules/kanban_board/model/column.dart';
export 'package:better_design_system/molecules/kanban_board/model/header.dart';

typedef BetterKanbanBoard = AppKanbanBoard;

class AppKanbanBoard<T, S> extends StatefulWidget {
  final List<KColumn> columns;

  final Function(T item, S previousColumn, S currentColumn)? onDrag;
  const AppKanbanBoard({super.key, required this.columns, this.onDrag});

  @override
  State<AppKanbanBoard> createState() => _AppKanbanBoardState();
}

class _AppKanbanBoardState<T, S> extends State<AppKanbanBoard<T, S>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    columns = widget.columns;
    super.initState();
  }

  @override
  void didUpdateWidget(AppKanbanBoard<T, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.columns != oldWidget.columns) {
      columns = widget.columns;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<KColumn> columns = [];

  S? hoveredColumnIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView.separated(
          //   scrollDirection: Axis.horizontal,
          //   itemCount: columns.length,
          //   separatorBuilder: (_, __) => const SizedBox(width: 16),
          //   itemBuilder: (context, index) {},
          // ),
          ...columns
              .mapIndexed((index, element) {
                return DragTarget<DraggableItem>(
                  onWillAcceptWithDetails: (data) {
                    if (columns[index].value == data.data.columnIndex) {
                      return false;
                    }

                    setState(() {
                      hoveredColumnIndex = columns[index].value;
                    });
                    return true;
                  },
                  onLeave: (data) {
                    setState(() {
                      hoveredColumnIndex = null;
                    });
                  },
                  onAcceptWithDetails: (data) {
                    setState(() {
                      hoveredColumnIndex = null;

                      (columns.firstWhereOrNull(
                        (element) => element.value == data.data.columnIndex,
                      ))?.children.removeWhere(
                        (element) => element.id == data.data.item.id,
                      );

                      columns[index].children.insert(0, data.data.item);
                    });

                    if (widget.onDrag != null) {
                      widget.onDrag!(
                        data.data.item.id,
                        data.data.columnIndex,
                        columns[index].value,
                      );
                    }
                  },
                  builder: (context, candidateData, rejectedData) {
                    return KanbanColumn(
                      column: columns[index],
                      hoveredColumnIndex: hoveredColumnIndex,
                    );
                  },
                );
              })
              .toList()
              .separated(separator: const SizedBox(width: 16)),
        ],
      ),
    );
  }
}
