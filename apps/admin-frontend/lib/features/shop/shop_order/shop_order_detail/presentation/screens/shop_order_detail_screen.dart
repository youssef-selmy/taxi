import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_customer_and_shop_detail.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_history.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_item.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_tab_bar.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_complaints/presentation/screens/shop_order_detail_complaints_screen.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/presentation/blocs/shop_order_detail_notes.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_notes/presentation/screens/shop_order_detail_notes_screen.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/presentation/screens/shop_order_detail_reviews_screen.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_transactions/presentation/screens/shop_order_detail_transactions_screen.dart';

part 'shop_order_detail_screen.desktop.dart';
part 'shop_order_detail_screen.mobile.dart';

@RoutePage()
class ShopOrderDetailScreen extends StatelessWidget {
  const ShopOrderDetailScreen({super.key, required this.shopOrderId});

  final String shopOrderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopOrderDetailBloc()..onStarted(shopOrderId),
        ),
        BlocProvider(
          create: (context) =>
              ShopOrderDetailNotesBloc()..onStarted(shopOrderId),
        ),
      ],
      child: context.responsive(
        ShopOrderDetailScreenMobile(shopOrderId: shopOrderId),
        lg: ShopOrderDetailScreenDesktop(shopOrderId: shopOrderId),
      ),
    );
  }
}
