import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/chat_bubble/chat_bubble.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

extension Enum$ComplaintActivityTypeX on Enum$ComplaintActivityType {
  Widget toView(
    BuildContext context, {
    required String? comment,
    required Enum$ComplaintStatus? statusFrom,
    required Enum$ComplaintStatus? statusTo,
    required DateTime createdAt,
    required Fragment$staffListItem? actor,
    required List<Fragment$staffListItem> assignedToStaffs,
    required List<Fragment$staffListItem> unassignedFromStaffs,
    required String senderName,
    required String senderTitle,
  }) {
    switch (this) {
      case Enum$ComplaintActivityType.AssignToOperator:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Text(
                context.tr.assignToStaffMessage(
                  actor?.userName ?? context.tr.unknown,
                  assignedToStaffs.map((e) => e.userName).join(', '),
                ),
                style: context.textTheme.labelMedium?.variant(context),
              ),
              const Spacer(),
              Text(
                createdAt.toTimeAgo,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        );

      case Enum$ComplaintActivityType.Comment:
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return ChatBubble(
              message: comment,
              isMe: actor?.id == state.profile?.id,
              time: createdAt,
              avatar: actor?.media?.address,
              name: actor?.userName,
            );
          },
        );

      case Enum$ComplaintActivityType.StatusChange:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.changeStatusMessage(
                actor?.userName ?? context.tr.unknown,
              ),
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                statusFrom!.chip(context),
                const SizedBox(width: 8),
                Text(
                  context.tr.to,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
                const SizedBox(width: 8),
                statusTo!.chip(context),
                const Spacer(),
                Text(
                  createdAt.toTimeAgo,
                  style: context.textTheme.labelMedium?.variant(context),
                ),
              ],
            ),
          ],
        );

      case Enum$ComplaintActivityType.$unknown:
        return Text(
          context.tr.unknown,
          style: context.textTheme.labelMedium?.variant(context),
        );
      case Enum$ComplaintActivityType.Create:
        return Row(
          children: <Widget>[
            Text(
              context.tr.fileComplaintMessage(senderName, senderTitle),
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const Spacer(),
            Text(
              createdAt.toTimeAgo,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ],
        );
      case Enum$ComplaintActivityType.UnassignFromOperators:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: <Widget>[
              Text(
                context.tr.unassignFromStaffMessage(
                  actor?.userName ?? context.tr.unknown,
                  unassignedFromStaffs.map((e) => e.userName).join(', '),
                ),
                style: context.textTheme.labelMedium?.variant(context),
              ),
              const Spacer(),
              Text(
                createdAt.toTimeAgo,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ],
          ),
        );
      case Enum$ComplaintActivityType.Update:
        return Padding(
          padding: EdgeInsets.all(24),
          child: Text(context.tr.update),
        );
      case Enum$ComplaintActivityType.Resolved:
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            '${actor?.userName ?? context.tr.unknown} ${context.tr.markedAsResolved}',
          ),
        );
    }
  }
}
