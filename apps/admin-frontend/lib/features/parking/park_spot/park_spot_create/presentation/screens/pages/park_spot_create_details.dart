import 'package:admin_frontend/core/enums/park_spot_type.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/upload_field/multi_image_upload.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/presentation/blocs/park_spot_create.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkSpotCreateDetails extends StatelessWidget {
  const ParkSpotCreateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkSpotCreateBloc>();
    return BlocBuilder<ParkSpotCreateBloc, ParkSpotCreateState>(
      builder: (context, state) {
        return switch (state.parkSpotState) {
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
                children: [
                  LayoutGrid(
                    rowGap: 16,
                    columnGap: 16,
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: const [auto, auto],
                    children: [
                      ...[
                        Enum$ParkSpotType.PUBLIC,
                        Enum$ParkSpotType.PERSONAL,
                      ].map(
                        (type) => AppListItem(
                          icon: type.icon,
                          actionType: ListItemActionType.radio,
                          title: type.name(context),
                          subtitle: type.description(context),
                          onTap: (value) => bloc.onTypeSelected(type),
                          isSelected: state.type == type,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  LargeHeader(title: context.tr.details),
                  const SizedBox(height: 24),
                  LayoutGrid(
                    rowGap: 16,
                    columnGap: 16,
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: const [auto, auto, auto, auto],
                    children: [
                      // UploadFieldSmall(
                      //   title: context.translate.uploadImage,
                      //   onChanged: (media) {
                      //   },
                      // ).withGridPlacement(
                      //   columnSpan: context.responsive(
                      //     1,
                      //     lg: 2,
                      //   ),
                      // ),
                      AppTextField(
                        initialValue: state.name,
                        label: context.tr.name,
                        onChanged: bloc.onNameChanged,
                      ),
                      AppTextField(
                        initialValue: state.address,
                        label: context.tr.address,
                        onChanged: bloc.onAddressChanged,
                      ),
                      MultiImageUpload(
                        images: state.images,
                        onChanged: bloc.onImagesChanged,
                      ).withGridPlacement(
                        columnSpan: context.responsive(1, lg: 2),
                      ),
                      AppTextField(
                        initialValue: state.description,
                        label: context.tr.description,
                        onChanged: bloc.onDescriptionChanged,
                        maxLines: 3,
                      ).withGridPlacement(
                        columnSpan: context.responsive(1, lg: 2),
                      ),
                    ],
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
