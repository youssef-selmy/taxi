import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/customer_profile/customer_profile_small.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';

class CustomerProfile extends StatelessWidget {
  const CustomerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
      builder: (context, state) {
        return CustomerProfileSmall(
          imageUrl: state.selectedCustomer?.profilePictureUrl,
          fullName: state.selectedCustomer?.fullName,
        );
      },
    );
  }
}
