import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/blocs/parking_order_detail.cubit.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_booking_detail.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_customer_detail.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_histories.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/components/parking_order_detail_tab_bar.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/presentation/screens/parking_order_detail_complaints_screen.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/presentation/blocs/parking_order_detail_notes.cubit.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_notes/presentation/screens/parking_order_detail_notes_screen.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/presentation/screens/parking_order_detail_reviews_screen.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_transactions/presentation/screens/parking_order_detail_transaction_screen.dart';

part 'parking_order_detail_screen.desktop.dart';
part 'parking_order_detail_screen.mobile.dart';

@RoutePage()
class ParkingOrderDetailScreen extends StatelessWidget {
  const ParkingOrderDetailScreen({super.key, required this.parkingOrderId});

  final String parkingOrderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ParkingOrderDetailBloc()
                ..onStarted(parkingOrderId: parkingOrderId),
        ),
        BlocProvider(
          create: (context) =>
              ParkingOrderDetailNotesBloc()..onStarted(parkingOrderId),
        ),
      ],
      child: context.responsive(
        ParkingOrderDetailScreenMobile(parkingOrderId: parkingOrderId),
        lg: ParkingOrderDetailScreenDesktop(parkingOrderId: parkingOrderId),
      ),
    );
  }
}
