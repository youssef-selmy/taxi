import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/blocs/shop_order_list.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/components/shop_order_list_statistics.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/components/shop_order_list_tab_bar.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/components/shop_order_list_table.dart';

part 'shop_order_list_screen.desktop.dart';
part 'shop_order_list_screen.mobile.dart';

@RoutePage()
class ShopOrderListScreen extends StatelessWidget {
  const ShopOrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrderListBloc()..onStarted(),
      child: context.responsive(
        const ShopOrderListScreenMobile(),
        lg: const ShopOrderListScreenDesktop(),
      ),
    );
  }
}
