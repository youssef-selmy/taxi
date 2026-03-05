import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/select_items.cubit.dart';
import 'package:better_design_system/organisms/step_indicator/horizontal_step_indicator.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/dispatcher_select_customer/select_customer.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/pages/checkout_options.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/pages/select_items.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/pages/select_location.dart';

part 'shop_dispatcher_screen.desktop.dart';
part 'shop_dispatcher_screen.mobile.dart';

@RoutePage()
class ShopDispatcherScreen extends StatelessWidget {
  const ShopDispatcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ShopDispatcherBloc()),
          BlocProvider(create: (context) => SelectItemsBloc()),
        ],
        child: ShopDispatcherScreenDesktop(),
      ),
    );
  }
}
