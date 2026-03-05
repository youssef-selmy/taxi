import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';

import 'package:admin_frontend/core/components/atoms/info_tile/info_tile.dart';
import 'package:admin_frontend/core/components/customer_profile/customer_profile_small.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';

class TransactionDetailsDialog extends StatelessWidget {
  final Fragment$customerDetails customer;
  final Fragment$customerTransaction transaction;

  const TransactionDetailsDialog({
    super.key,
    required this.customer,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      onClosePressed: () => Navigator.of(context).pop(),
      primaryButton: AppOutlinedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        text: context.tr.ok,
      ),
      icon: BetterIcons.bookOpen01Outline,
      title: context.tr.transactionDetails,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomerProfileSmall(
                  imageUrl: customer.avatarUrl,
                  fullName: customer.fullName,
                ),
              ),
              InfoTile(
                isLoading: false,
                iconData: BetterIcons.calendar04Filled,
                data: transaction.createdAt.formatDateTime,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.transactionType,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    transaction.tableViewType(context),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.amount,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    transaction.amountView(context),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.paymentMethod,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    transaction.tableViewPaymentMethod(context),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.referenceNumber,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    transaction.status.chip(context),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.referenceNumber,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction.refrenceNumber ?? "",
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.tr.description,
                      style: context.textTheme.labelMedium?.variant(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transaction.description ?? "",
                      style: context.textTheme.labelMedium,
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
}
