import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/map/search_location.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:better_icons/better_icons.dart';

class AppSearchLocationBar extends StatefulWidget {
  final Function(Fragment$Place) onPlaceSelected;

  const AppSearchLocationBar({super.key, required this.onPlaceSelected});

  @override
  State<AppSearchLocationBar> createState() => _AppSearchLocationBarState();
}

class _AppSearchLocationBarState extends State<AppSearchLocationBar> {
  final _overlayPortalController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<SearchLocationCubit>(),
      child: OverlayPortal(
        controller: _overlayPortalController,
        overlayChildBuilder: (context) {
          return CompositedTransformFollower(
            offset: const Offset(0, 12),
            targetAnchor: Alignment.bottomCenter,
            followerAnchor: Alignment.topCenter,
            link: _link,
            child: Align(
              alignment: Alignment.topCenter,
              child: BlocProvider.value(
                value: locator<SearchLocationCubit>(),
                child: BlocBuilder<SearchLocationCubit, SearchLocationState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: kThemeAnimationDuration,
                      child: switch (state) {
                        ApiResponseInitial() => const SizedBox.shrink(),
                        ApiResponseLoading() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ApiResponseLoaded(:final data) => Container(
                          height: 200,
                          width: 450,
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final place = data[index];
                              return ListTile(
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colors.outline,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(
                                    BetterIcons.gps01Filled,
                                    size: 20,
                                    color: context.colors.primary,
                                  ),
                                ),
                                title: Text(place.title ?? ""),
                                subtitle: Text(place.address),
                                onTap: () {
                                  widget.onPlaceSelected(place);
                                },
                              );
                            },
                          ),
                        ),
                        ApiResponseError(:final errorMessage) => Center(
                          child: Text(
                            errorMessage ?? context.tr.anErrorOccurred,
                          ),
                        ),
                        _ => const SizedBox.shrink(),
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
        child: CompositedTransformTarget(
          link: _link,
          child: BlocBuilder<SearchLocationCubit, SearchLocationState>(
            builder: (context, state) {
              return AppTextField(
                isFilled: false,
                density: TextFieldDensity.dense,
                hint: context.tr.searchLocation,
                onChanged: (p0) {
                  locator<SearchLocationCubit>().stopTyping(query: p0);
                },
                prefixIcon: const Icon(BetterIcons.search01Filled, size: 24),
                suffixIcon: switch (state) {
                  ApiResponseLoading() => CupertinoActivityIndicator(
                    radius: 8,
                    color: context.colors.primary,
                  ),
                  _ => null,
                },
                onFocused: () {
                  _overlayPortalController.show();
                },
                onUnfocused: () {
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () => _overlayPortalController.hide(),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
