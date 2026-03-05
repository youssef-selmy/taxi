import 'package:better_design_system/atoms/input_fields/number_field/number_field.dart';
import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/atoms/accordion/checkable_accordion_raised.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/blocs/vendor_create.cubit.dart';
import 'package:better_icons/better_icons.dart';

class VendorCreateDeliveryPaymentsPage extends StatelessWidget {
  const VendorCreateDeliveryPaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<VendorCreateBloc>();
    return BlocBuilder<VendorCreateBloc, VendorCreateState>(
      builder: (context, state) {
        return switch (state.vendorState) {
          ApiResponseError(:final message) => Center(child: Text(message)),
          ApiResponseInitial() => const SizedBox.shrink(),
          ApiResponseLoading() => const Center(
            child: CupertinoActivityIndicator(),
          ),
          ApiResponseLoaded() => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.responsive(16, lg: 40),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LargeHeader(
                    title: context.tr.ownerInformation,
                    size: HeaderSize.large,
                  ),
                  const SizedBox(height: 16),
                  CheckableAccordionRaised(
                    onChanged: bloc.onIsShopDeliveryAvailableChanged,
                    title: context.tr.shopDelivery,
                    value: state.isShopDeliveryAvailable,
                  ),
                  const SizedBox(height: 16),
                  CheckableAccordionRaised(
                    onChanged: bloc.onIsExpressDeliveryAvailableChanged,
                    title: context.tr.expressDelivery,
                    value: state.isExpressDeliveryAvailable,
                    child: AppNumberField.integer(
                      minValue: 0,
                      maxValue: 100,
                      hint: "%",
                      initialValue: state.expressDeliveryShopCommission,
                      onChanged: bloc.onExpressDeliveryShopCommissionChanged,
                      title: context.tr.shopCommission,
                    ),
                  ),
                  const SizedBox(height: 32),
                  LargeHeader(
                    title: context.tr.payment,
                    size: HeaderSize.large,
                  ),
                  const SizedBox(height: 16),
                  CheckableAccordionRaised(
                    onChanged: bloc.onIsCashPaymentAvailableChanged,
                    title: context.tr.cashPayment,
                    icon: BetterIcons.money03Filled,
                    value: state.isCashPaymentAvailable,
                  ),
                  const SizedBox(height: 16),
                  CheckableAccordionRaised(
                    onChanged: bloc.onIsOnlinePaymentAvailableChanged,
                    icon: BetterIcons.creditCardFilled,
                    title: context.tr.onlinePayment,
                    value: state.isOnlinePaymentAvailable,
                  ),
                ],
              ),
            ),
          ),
        };
      },
    );
  }
}
