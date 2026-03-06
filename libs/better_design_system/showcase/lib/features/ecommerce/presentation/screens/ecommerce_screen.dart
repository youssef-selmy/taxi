import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/screens/ecommerce_cart.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_cart/screens/ecommerce_cart.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/screens/ecommerce_dashboard.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_dashboard/screens/ecommerce_dashboard.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/screens/ecommerce_home.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_home/screens/ecommerce_home.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/screens/ecommerce_order_details.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_order_details/screens/ecommerce_order_details.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_orders/screens/ecommerce_orders.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_orders/screens/ecommerce_orders.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/screens/ecommerce_product_details.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_product_details/screens/ecommerce_product_details.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products/screens/ecommerce_products.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products/screens/ecommerce_products.mobile.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products_list/screens/ecommerce_products_list.desktop.dart';
import 'package:better_design_showcase/features/ecommerce/presentation/components/ecommerce_products_list/screens/ecommerce_products_list.mobile.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class EcommerceScreen extends StatelessWidget {
  const EcommerceScreen({super.key});

  static const double _maxHeight = 1000;

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Templates',
            currentTitle: 'E-commerce',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            icon: Assets.images.iconsTwotone.shoppingCart01.svg(
              width: 20,
              height: 20,
            ),
            iconBackgroundColor: context.colors.insight,
            iconColor: context.colors.onInsight,
            title: 'E-Commerce',
            description:
                'A complete e-commerce template including a dashboard, product listings, product details, cart, and order management screens.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                title: 'Dashboard',
                maxHeight: _maxHeight,
                desktopWidget: EcommerceDashboardDesktop(),
                mobileWidget: EcommerceDashboardMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_dashboard.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_dashboard.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Products List',
                desktopWidget: EcommerceProductsListDesktop(),
                maxHeight: _maxHeight,
                mobileWidget: EcommerceProductsListMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_products_list.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_products_list.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Product Details',
                maxHeight: _maxHeight,
                desktopWidget: EcommerceProductDetailsDesktop(),
                mobileWidget: EcommerceProductsDetailsMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_product_details.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_product_details.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxHeight: _maxHeight,
                title: 'Orders',
                desktopWidget: EcommerceOrdersDesktop(),
                mobileWidget: EcommerceOrdersMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_orders.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_orders.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxHeight: _maxHeight,
                title: 'Order Details',
                desktopWidget: EcommerceOrderDetailsDesktop(),
                mobileWidget: EcommerceOrderDetailsMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_order_details.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_order_details.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Home',
                maxHeight: _maxHeight,
                desktopWidget: EcommerceHomeDesktop(),
                mobileWidget: EcommerceHomeMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_home.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_home.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Products',
                maxHeight: _maxHeight,
                desktopWidget: EcommerceProductsDesktop(),
                mobileWidget: EcommerceProductsMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_products.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_products.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Cart',
                maxHeight: _maxHeight,
                desktopWidget: EcommerceCartDesktop(),
                mobileWidget: EcommerceCartMobile(),
                desktopSourceCode:
                    'templates/ecommerce/ecommerce_cart.desktop.txt',
                mobileSourceCode:
                    'templates/ecommerce/ecommerce_cart.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenMode: FullScreenMode.customFullScreen,
                fullScreenType: FullScreenType.dashboard,
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
