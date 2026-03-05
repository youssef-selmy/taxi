import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/address.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/address.cubit.dart';

class CustomerDetailsAddresses extends StatelessWidget {
  final String customerId;

  const CustomerDetailsAddresses({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressBloc()..onStarted(customerId: customerId),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                return AppDataTable(
                  columns: [
                    DataColumn2(
                      label: Text(context.tr.title),
                      size: ColumnSize.S,
                    ),
                    DataColumn(label: Text(context.tr.address)),
                  ],
                  getRowCount: (data) => data.addresses.nodes.length,
                  rowBuilder: (data, index) => rowBuilder(context, data, index),
                  getPageInfo: (data) => data.addresses.pageInfo,
                  data: state.networkState,
                  onPageChanged: context.read<AddressBloc>().onPageChanged,
                  paging: state.paging,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataRow rowBuilder(
    BuildContext context,
    Query$customerAddresses data,
    int index,
  ) {
    final address = data.addresses.nodes[index];
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Icon(address.icon, color: context.colors.primary),
              const SizedBox(width: 8),
              Text(address.title, style: context.textTheme.labelMedium),
            ],
          ),
        ),
        DataCell(
          Text(
            address.details ?? "",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
      ],
    );
  }
}
