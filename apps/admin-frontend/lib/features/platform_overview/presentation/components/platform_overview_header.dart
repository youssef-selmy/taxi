import 'package:admin_frontend/core/components/dashboard_header.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/enums/kpi_period.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformOverviewHeader extends StatelessWidget {
  const PlatformOverviewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DashboardHeader(),
            Flex(
              direction: context.isDesktop ? Axis.horizontal : Axis.vertical,
              spacing: 8,
              children: [
                AppDropdownField.single(
                  type: DropdownFieldType.compact,
                  prefixIcon: BetterIcons.calendar03Outline,
                  isFilled: false,
                  width: 160,
                  items: Enum$KPIPeriod.values
                      .where((e) => e != Enum$KPIPeriod.$unknown)
                      .map(
                        (e) => AppDropdownItem<Enum$KPIPeriod>(
                          title: e.title(context),
                          value: e,
                        ),
                      )
                      .toList(),
                  initialValue: state.period,
                  onChanged: (period) {
                    if (period != null) {
                      context.read<PlatformOverviewCubit>().onChangedPeriod(
                        period,
                      );
                    }
                  },
                ),
                SizedBox(
                  width: 160,
                  child: AppDroopdownCurrency(
                    prefixIcon: BetterIcons.dollarCircleOutline,
                    isCompact: true,
                    showTitle: false,
                    initialValue: state.currency,
                    onChanged: (currency) => context
                        .read<PlatformOverviewCubit>()
                        .onCurrencyChanged(currency!),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
