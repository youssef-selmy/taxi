import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/blocs/parking_dispatcher.cubit.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/presentation/components/parking_list_item.dart';

class ParkingsList extends StatelessWidget {
  const ParkingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingDispatcherBloc, ParkingDispatcherState>(
      builder: (context, state) {
        return ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item =
                state.parkings.data?.elementAtOrNull(index) ??
                mockParkSpotDetail;
            return ParkingListItem(
              item: item,
              selectedDestination: state.selectedDestination,
              onSelected: context
                  .read<ParkingDispatcherBloc>()
                  .onParkingSelected,
              isSelected: state.selectedParking?.id == item.id,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: state.parkings.data?.length ?? 10,
        );
      },
    );
  }
}
