import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:better_design_system/molecules/send_message/send_message.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/complaint_activity_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/presentation/blocs/taxi_support_request_detail.cubit.dart';

class TaxiSupportRequestDetailActivity extends StatefulWidget {
  const TaxiSupportRequestDetailActivity({super.key});

  @override
  State<TaxiSupportRequestDetailActivity> createState() =>
      _TaxiSupportRequestDetailActivityState();
}

class _TaxiSupportRequestDetailActivityState
    extends State<TaxiSupportRequestDetailActivity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaxiSupportRequestDetailBloc>();
    return BlocBuilder<
      TaxiSupportRequestDetailBloc,
      TaxiSupportRequestDetailState
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
                        itemCount: data?.taxiSupportRequest.activities.length,
                        itemBuilder: (context, index) {
                          final activity =
                              data?.taxiSupportRequest.activities[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              activity?.type.toView(
                                    context,
                                    comment: activity.comment,
                                    createdAt: activity.createdAt,
                                    assignedToStaffs: activity.assignedToStaffs,
                                    unassignedFromStaffs:
                                        activity.unassignedFromStaffs,
                                    actor: activity.actor,
                                    statusFrom: activity.statusFrom,
                                    statusTo: activity.statusTo,
                                    senderName:
                                        data?.taxiSupportRequest.senderName ??
                                        "-",
                                    senderTitle:
                                        data?.taxiSupportRequest.senderTitle(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppSendMessage(
                      onChanged: bloc.onCommentChanged,
                      sendState: state.createCommentState,
                      onSend: (message) {
                        if (_formKey.currentState!.validate()) {
                          bloc.onAddComment();
                        }
                      },
                    ),
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
