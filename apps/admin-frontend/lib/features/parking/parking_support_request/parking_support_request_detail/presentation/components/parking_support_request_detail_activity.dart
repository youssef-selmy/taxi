import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/complaint_activity_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/presentation/blocs/parking_support_request_detail.cubit.dart';

class ParkingSupportRequestDetailActivity extends StatefulWidget {
  const ParkingSupportRequestDetailActivity({super.key});

  @override
  State<ParkingSupportRequestDetailActivity> createState() =>
      _ParkingSupportRequestDetailActivityState();
}

class _ParkingSupportRequestDetailActivityState
    extends State<ParkingSupportRequestDetailActivity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingSupportRequestDetailBloc>();
    return BlocBuilder<
      ParkingSupportRequestDetailBloc,
      ParkingSupportRequestDetailState
    >(
      builder: (context, state) {
        final data = state.supportRequestState.data;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: kBorder(context),
            color: context.colors.surface,
            boxShadow: kElevation1(context),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LargeHeader(title: context.tr.activities),
                  ),
                  const Divider(height: 32),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            data?.parkingSupportRequest.activities.length,
                        itemBuilder: (context, index) {
                          final activity =
                              data?.parkingSupportRequest.activities[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              activity?.type.toView(
                                    context,
                                    comment: activity.comment,
                                    statusFrom: activity.statusFrom,
                                    statusTo: activity.statusTo,
                                    createdAt: activity.createdAt,
                                    actor: activity.actor,
                                    assignedToStaffs: activity.assignedToStaffs,
                                    unassignedFromStaffs:
                                        activity.unassignedFromStaffs,
                                    senderName:
                                        data?.parkingSupportRequest.senderName(
                                          context,
                                        ) ??
                                        "-",
                                    senderTitle:
                                        data?.parkingSupportRequest.senderTitle(
                                          context,
                                        ) ??
                                        "-",
                                  ) ??
                                  const SizedBox(),
                              const SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  AppSendMessage(
                    onChanged: bloc.onCommentChanged,
                    sendState: state.createCommentState,
                    onSend: (message) {
                      if (_formKey.currentState!.validate()) {
                        bloc.onAddComment();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
