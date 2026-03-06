import 'dart:async';

import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/input_fields/text_field/text_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_map/generic_map.dart';

typedef BetterSearchLocationField = AppSearchLocationField;

class AppSearchLocationField extends StatefulWidget {
  final Function(Place) onPlaceSelected;
  final Future<ApiResponse<List<Place>>> Function(String query) onSearch;

  const AppSearchLocationField({
    super.key,
    required this.onPlaceSelected,
    required this.onSearch,
  });

  @override
  createState() => _AppSearchLocationFieldState();
}

class _AppSearchLocationFieldState extends State<AppSearchLocationField> {
  final _overlayPortalController = OverlayPortalController();
  final _link = LayerLink();
  bool isExpanded = false;
  final GlobalKey _containerKey = GlobalKey();

  SearchState searchState = SearchState.initial;

  Timer? _debounce;

  String? error;

  List<Place> places = [];

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      key: _containerKey,
      controller: _overlayPortalController,
      overlayChildBuilder: (context) {
        // get the _containerKey position
        final RenderBox renderBox =
            _containerKey.currentContext!.findRenderObject() as RenderBox;
        // get the _containerKey size
        final size = renderBox.size;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _overlayPortalController.hide();
            setState(() => isExpanded = false);
          },
          child: CompositedTransformFollower(
            offset: Offset(0, size.height + 8),
            link: _link,
            child: Align(
              alignment: Alignment.topLeft,
              child: AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child: switch (searchState) {
                  SearchState.initial => const SizedBox.shrink(),
                  SearchState.typing ||
                  SearchState.loading => const SizedBox.shrink(),
                  SearchState.success => Container(
                    width: size.width,
                    constraints: const BoxConstraints(maxHeight: 250),
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      boxShadow: [
                        BoxShadow(
                          color: context.colors.shadow,
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        final place = places[index];
                        return CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            widget.onPlaceSelected(place);
                            _overlayPortalController.hide();
                            setState(() {
                              searchState = SearchState.initial;
                              isExpanded = false;
                            });
                          },
                          minimumSize: const Size(0, 0),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: context.colorScheme.outline,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                BetterIcons.location01Filled,
                                size: 20,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            title: Text(place.title ?? ''),
                            subtitle: Text(place.address),
                          ),
                        );
                      },
                    ),
                  ),
                  SearchState.error => Center(
                    child: Text(error ?? 'An error occurred'),
                  ),
                },
              ),
            ),
          ),
        );
      },
      child: CompositedTransformTarget(
        link: _link,
        child: AppTextField(
          isFilled: true,
          hint: 'Search location',
          onChanged: _onSearchChanged,
          prefixIcon: const Icon(BetterIcons.search01Filled, size: 24),
          suffixIcon: switch (searchState) {
            SearchState.loading ||
            SearchState.typing => CupertinoActivityIndicator(
              radius: 8,
              color: context.colorScheme.primary,
            ),
            _ => null,
          },
          onFocused: () {
            _overlayPortalController.show();
          },
          onUnfocused: () {
            Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                isExpanded = false;
              });
              _overlayPortalController.hide();
            });
          },
        ),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    if (query.isEmpty) {
      setState(() {
        searchState = SearchState.initial;
        places = [];
      });
      _overlayPortalController.hide();
      return;
    } else {
      setState(() {
        searchState = SearchState.typing;
      });
    }
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() {
        searchState = SearchState.loading;
      });
      if (query.isEmpty) return;
      final result = await widget.onSearch(query);
      setState(() {
        result.fold(
          (error, {failure}) {
            searchState = SearchState.error;
            this.error = error;
          },
          (data) {
            searchState = SearchState.success;
            places = data;
            // Show overlay when results are ready
            if (data.isNotEmpty) {
              _overlayPortalController.show();
            }
          },
        );
      });
    });
  }
}

enum SearchState { initial, typing, loading, success, error }
