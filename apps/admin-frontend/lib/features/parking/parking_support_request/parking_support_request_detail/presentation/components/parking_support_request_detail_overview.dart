import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/link_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/molecules/select_user_dropdown/select_user_dropdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_status/dropdown_status.dart';
import 'package:admin_frontend/core/enums/complaint_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/presentation/blocs/parking_support_request_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingSupportRequestDetailOverview extends StatelessWidget {
  const ParkingSupportRequestDetailOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingSupportRequestDetailBloc>();
    return BlocBuilder<
      ParkingSupportRequestDetailBloc,
      ParkingSupportRequestDetailState
    >(
      builder: (context, state) {
        final data = state.supportRequestState.data;
        final supportRequest = data?.parkingSupportRequest;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: kBorder(context),
            color: context.colors.surface,
            boxShadow: kElevation1(context),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    context.tr.overview,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Text(
                        context.tr.dateAndTime,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const Spacer(),
                      Text(
                        supportRequest?.createdAt.formatDateTime ?? "-",
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Text(
                        context.tr.status,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const Spacer(),
                      if (supportRequest != null)
                        AppDropdownStatus<Enum$ComplaintStatus>(
                          items: Enum$ComplaintStatus.values
                              .toDropdownStatusItems(context),
                          initialValue: supportRequest.status,
                          onChanged: bloc.onStatusChanged,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Text(
                        context.tr.assignedTo,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const Spacer(),
                      if (data != null)
                        AppSelectUserDropdown<Fragment$staffListItem>(
                          selectedValues:
                              data.parkingSupportRequest.assignedToStaffs,
                          items: data.staffs.nodes.toOperatorFilterItems(
                            context,
                          ),
                          onChanged: bloc.onAssignChanged,
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Text(
                        context.tr.submittedBy,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                      const Spacer(),
                      Text(
                        supportRequest?.senderTitle(context) ?? "-",
                        style: context.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  Row(
                    children: <Widget>[
                      Text(
                        context.tr.orders,
                        style: context.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      AppTextButton(
                        onPressed: () {
                          context.router.push(
                            ParkingOrderDetailRoute(
                              parkingOrderId: supportRequest!.parkOrder.id,
                            ),
                          );
                        },
                        text: context.tr.orderDetails,
                        suffixIcon: BetterIcons.arrowRight02Outline,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child:
                            supportRequest?.parkOrder.carOwner?.tableView(
                              context,
                              showTitle: true,
                            ) ??
                            const SizedBox(),
                      ),
                      AppLinkButton(
                        text:
                            supportRequest?.parkOrder.carOwner?.mobileNumber
                                .formatPhoneNumber(null) ??
                            "-",
                        onPressed: () {
                          launchUrlString(
                            'tel:+${supportRequest?.parkOrder.carOwner?.mobileNumber}',
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child:
                            supportRequest?.parkOrder.spotOwner?.tableView(
                              context,
                            ) ??
                            const SizedBox(),
                      ),
                      AppLinkButton(
                        text:
                            supportRequest?.parkOrder.spotOwner?.mobileNumber
                                .formatPhoneNumber(null) ??
                            "-",
                        onPressed: () {
                          launchUrlString(
                            'tel:+${supportRequest?.parkOrder.spotOwner?.mobileNumber}',
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  LargeHeader(title: context.tr.title),
                  const SizedBox(height: 16),
                  Text(
                    supportRequest?.content ?? context.tr.noContent,
                    style: context.textTheme.labelMedium?.variant(context),
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
