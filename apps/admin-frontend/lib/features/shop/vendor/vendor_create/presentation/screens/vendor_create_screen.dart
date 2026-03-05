import 'package:admin_frontend/core/router/app_router.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/blocs/vendor_create.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/screens/pages/vendor_create_categories_location_page.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/screens/pages/vendor_create_delivery_payments_page.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/screens/pages/vendor_create_owner_information_page.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/screens/pages/vendor_create_shop_detail_page.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class VendorCreateScreen extends StatefulWidget {
  final String? vendorId;

  const VendorCreateScreen({super.key, @PathParam('vendorId') this.vendorId});

  @override
  State<VendorCreateScreen> createState() => _VendorCreateScreenState();
}

class _VendorCreateScreenState extends State<VendorCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VendorCreateBloc()..onStarted(vendorId: widget.vendorId),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding.copyWith(left: 0, right: 0, bottom: 16),
        child: BlocConsumer<VendorCreateBloc, VendorCreateState>(
          listener: (context, state) {
            if (state.saveState.isLoaded) {
              context.showSuccess(null);
              context.router.replace(VendorListRoute());
            }
            if (state.saveState.isError) {
              context.showFailure(state.saveState);
            }
            if (state.vendorState.isError) {
              context.showFailure(state.vendorState);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: context.pagePaddingHorizontal,
                  child: PageHeader(
                    title: isCreate
                        ? context.tr.createShop
                        : context.tr.verifyShop,
                    subtitle: isCreate
                        ? context.tr.createNewShop
                        : context.tr.verifyShopRegistration,
                    showBackButton: true,
                    onBackButtonPressed: () {
                      context.router.replace(const VendorListRoute());
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: context.pagePaddingHorizontal,
                  child: AppHorizontalStepIndicator(
                    connectorStyle: ConnectorStyle.line,
                    style: StepIndicatorItemStyle.circular,
                    items: [
                      StepIndicatorItem(
                        label: context.tr.details,
                        value: 0,
                        description: context.tr.details,
                      ),
                      StepIndicatorItem(
                        label: context.tr.categoriesAndLocation,
                        value: 1,
                        description: context.tr.selectCategoriesAndLocation,
                      ),
                      StepIndicatorItem(
                        label: context.tr.ownerInformation,
                        value: 2,
                        description: context.tr.editOwnersInformation,
                      ),
                      StepIndicatorItem(
                        label: context.tr.deliveryAndPayments,
                        value: 3,
                        description: context.tr.selectDeliveryAndPaymentMethods,
                      ),
                    ],
                    selectedStep: state.wizardStep,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: PageView(
                    controller: state.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      VendorCreateShopDetailPage(),
                      VendorCreateCategoriesLocationPage(),
                      VendorCreateOwnerInformationPage(),
                      VendorCreateDeliveryPaymentsPage(),
                    ],
                  ),
                ),
                const Divider(height: 16),
                const SizedBox(height: 8),
                Padding(
                  padding: context.pagePaddingHorizontal,
                  child: Row(
                    children: [
                      if (state.wizardStep != 0)
                        AppOutlinedButton(
                          onPressed: context
                              .read<VendorCreateBloc>()
                              .onPreviousPage,
                          prefixIcon: BetterIcons.arrowLeft02Outline,
                          text: context.tr.back,
                        ),
                      const Spacer(),
                      if (state.wizardStep < 3)
                        AppFilledButton(
                          onPressed: context
                              .read<VendorCreateBloc>()
                              .onNextPage,
                          text: context.tr.next,
                          suffixIcon: BetterIcons.arrowRight02Outline,
                        ),
                      if (state.wizardStep == 3)
                        AppFilledButton(
                          onPressed: context.read<VendorCreateBloc>().onSubmit,
                          text: context.tr.register,
                          suffixIcon: BetterIcons.arrowRight02Outline,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool get isCreate => widget.vendorId == null;
}
