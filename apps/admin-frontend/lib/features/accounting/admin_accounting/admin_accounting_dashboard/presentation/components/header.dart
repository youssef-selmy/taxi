import 'package:flutter/cupertino.dart';

import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/chart_filter_inputs/chart_filter_inputs.dart';
import 'package:admin_frontend/core/entities/chart_filter_input.extensions.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';

class AdminAccountingDashboardHeader extends StatelessWidget {
  const AdminAccountingDashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.adminWallet,
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              BlocBuilder<
                AdminAccountingDashboardBloc,
                AdminAccountingDashboardState
              >(
                builder: (context, state) => Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: context.tr.statisticFor,
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                      TextSpan(
                        text:
                            " ${state.chartFilterInput.interval.format(state.chartFilterInput.startDate)}",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, stateAuth) {
                return AppDropdownField.single(
                  type: DropdownFieldType.compact,
                  isFilled: false,
                  width: 100,
                  initialValue: stateAuth.selectedCurrency,
                  onChanged: (p0) {
                    context.read<AuthBloc>().add(AuthEvent$ChangeCurrency(p0!));
                  },
                  items: stateAuth.supportedCurrencies
                      .map(
                        (currency) =>
                            AppDropdownItem(title: currency, value: currency),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<
              AdminAccountingDashboardBloc,
              AdminAccountingDashboardState
            >(
              builder: (context, state) => ChartFilterInputs(
                onChanged: (p0) => context
                    .read<AdminAccountingDashboardBloc>()
                    .changeChartFilterInput(p0),
                defaultValue: state.chartFilterInput,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
