import 'package:flutter/cupertino.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/organisms/phone_number_field/phone_number_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/components/upload_field/upload_field_small.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/presentation/blocs/vendor_create.cubit.dart';

class VendorCreateShopDetailPage extends StatelessWidget {
  const VendorCreateShopDetailPage({super.key});

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
                children: [
                  LargeHeader(title: context.tr.details),
                  const SizedBox(height: 24),
                  LayoutGrid(
                    rowGap: 16,
                    columnGap: 16,
                    columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                    rowSizes: List.generate(
                      context.responsive(6, lg: 4),
                      (_) => auto,
                    ),
                    children: [
                      UploadFieldSmall(
                        title: context.tr.uploadImage,
                        onChanged: (media) {
                          bloc.onImageChanged(media);
                        },
                      ).withGridPlacement(
                        columnSpan: context.responsive(1, lg: 2),
                      ),
                      AppTextField(
                        initialValue: state.name,
                        label: context.tr.name,
                        onChanged: bloc.onNameChanged,
                      ),
                      AppTextField(
                        initialValue: state.password,
                        label: context.tr.password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: bloc.onPasswordChanged,
                      ),
                      AppTextField(
                        initialValue: state.description,
                        label: context.tr.description,
                        onChanged: bloc.onDescriptionChanged,
                        maxLines: 3,
                      ).withGridPlacement(
                        columnSpan: context.responsive(1, lg: 2),
                      ),
                      AppTextField(
                        initialValue: state.email,
                        label: context.tr.email,
                        onChanged: bloc.onEmailChanged,
                      ),
                      AppPhoneNumberField(
                        label: context.tr.mobileNumber,
                        initialValue: state.phoneNumber,
                        onChanged: bloc.onPhoneNumberChanged,
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
