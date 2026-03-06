import 'package:better_design_system/molecules/kanban_board/model/card_item.dart';
import 'package:better_design_system/molecules/kanban_board/kanban_board.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppKanbanBoard)
Widget defaultKanbanBoard(BuildContext context) {
  return SizedBox(
    width: 850,
    height: 800,
    child: Padding(
      padding: const EdgeInsets.all(30),
      child: AppKanbanBoard(
        onDrag: (item, previousColumn, currentColumn) {},
        columns: [
          KColumn(
            header: KColumnHeader(
              title: 'Pending',
              icon: BetterIcons.clock01Outline,
              trailing: [
                Icon(
                  BetterIcons.addCircleOutline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
                Icon(
                  BetterIcons.moreVerticalCircle01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            children: List.generate(
              2,
              (index) => CardItem(
                widget: item(
                  context,
                  statusColor: Color(0xff919EAB).withValues(alpha: 0.12),
                  statusIconColor: context.colors.onSurfaceVariant,
                  statusIcon: BetterIcons.clock01Filled,
                  statusText: 'Pending',
                ),
                id: '${index + 1}',
              ),
            ),
            value: 'Pending',
          ),
          KColumn(
            header: KColumnHeader(
              title: 'In Progress',
              icon: BetterIcons.loading03Outline,
              trailing: [
                Icon(
                  BetterIcons.addCircleOutline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
                Icon(
                  BetterIcons.moreVerticalCircle01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            children: List.generate(
              1,
              (index) => CardItem(
                widget: item(
                  context,
                  statusColor: context.colors.infoContainer,
                  statusIconColor: context.colors.info,
                  statusIcon: BetterIcons.loading03Outline,
                  statusText: 'In Progress',
                ),
                id: '${index + 1}',
              ),
            ),
            value: 'In Progress',
          ),
          KColumn(
            header: KColumnHeader(
              title: 'Out For Delivey',
              icon: BetterIcons.truckDeliveryOutline,
              trailing: [
                Icon(
                  BetterIcons.addCircleOutline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
                Icon(
                  BetterIcons.moreVerticalCircle01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            children: List.generate(
              3,
              (index) => CardItem(
                widget: item(
                  context,
                  statusColor: context.colors.insightContainer,
                  statusIconColor: context.colors.insight,
                  statusIcon: BetterIcons.truckDeliveryFilled,
                  statusText: 'Delivey',
                ),
                id: '${index + 1}',
              ),
            ),
            value: 'Out For Delivey',
          ),
          KColumn(
            header: KColumnHeader(
              title: 'Delivered',
              icon: BetterIcons.checkmarkCircle02Outline,
              trailing: [
                Icon(
                  BetterIcons.addCircleOutline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
                Icon(
                  BetterIcons.moreVerticalCircle01Outline,
                  size: 20,
                  color: context.colors.onSurface,
                ),
              ],
            ),
            children: List.generate(
              2,
              (index) => CardItem(
                widget: item(
                  context,
                  statusColor: context.colors.successContainer,
                  statusIconColor: context.colors.success,
                  statusIcon: BetterIcons.checkmarkCircle02Filled,
                  statusText: 'Delivered',
                ),
                id: '${index + 1}',
              ),
            ),
            value: 'Delivered',
          ),
        ],
      ),
    ),
    // child: SingleChildScrollView(
    //   scrollDirection: Axis.horizontal,
    //   child: Row(
    //     children: [
    //       ...[1, 2, 3, 4]
    //           .map((e) => Container(height: 300, width: 400, color: Colors.red))
    //           .toList()
    //           .separated(separator: SizedBox(width: 100)),
    //     ],
    //   ),
    // ),
  );
}

Widget item(
  BuildContext context, {
  required Color statusColor,
  required Color statusIconColor,
  required String statusText,
  required IconData statusIcon,
}) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      spacing: 16,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xff919EAB).withValues(alpha: 0.12),
              ),
              child: Text(
                '#ORD-18923',
                style: context.textTheme.labelSmall?.variant(context),
              ),
            ),

            Text(
              '5m ago',
              style: context.textTheme.labelSmall?.variant(context),
            ),
          ],
        ),

        Row(
          spacing: 8,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: context.colors.surfaceVariant,
              ),
              child: Icon(
                BetterIcons.building02Filled,
                size: 20,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Column(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'pharmacy:',
                  style: context.textTheme.labelMedium?.variant(context),
                ),
                Text('Dr Stiler', style: context.textTheme.labelLarge),
              ],
            ),
          ],
        ),

        Row(
          spacing: 8,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: context.colors.surfaceVariant,
              ),
              child: Icon(
                BetterIcons.userCircle02Filled,
                size: 20,
                color: context.colors.onSurfaceVariant,
              ),
            ),
            Column(
              spacing: 4,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Customer:',
                  style: context.textTheme.labelMedium?.variant(context),
                ),
                Text('Joseph Campbell', style: context.textTheme.labelLarge),
              ],
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xff919EAB).withValues(alpha: 0.12),
              ),
              child: Row(
                spacing: 4,
                children: [
                  Icon(
                    BetterIcons.shoppingBasket03Filled,
                    size: 20,
                    color: context.colors.primaryBold,
                  ),
                  Text(
                    '5 item',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.primaryBold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: statusColor,
              ),
              child: Row(
                spacing: 4,
                children: [
                  Icon(statusIcon, size: 20, color: statusIconColor),
                  Text(
                    statusText,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: statusIconColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
