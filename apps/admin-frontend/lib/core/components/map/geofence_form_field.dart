import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/molecules/tooltip/tooltip.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:flutter/material.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:latlong2/latlong.dart';

class AppGeofenceFormField extends StatefulWidget {
  final List<Fragment$Coordinate>? initialValue;
  final void Function(List<Input$PointInput>?)? onSaved;
  final void Function(List<Input$PointInput>?)? onChanged;
  final String? Function(List<Fragment$Coordinate>?)? validator;

  const AppGeofenceFormField({
    super.key,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.onChanged,
  });

  @override
  State<AppGeofenceFormField> createState() => _AppGeofenceFormFieldState();
}

class _AppGeofenceFormFieldState extends State<AppGeofenceFormField> {
  final history = <List<Fragment$Coordinate>>[];
  final historyIndex = <int>[];
  final historyLimit = 10;

  List<LatLng> sanitizedPoints(List<LatLng> points) {
    if (points.isEmpty) return [];
    if (points.firstOrNull?.latitude != points.lastOrNull?.latitude ||
        points.firstOrNull?.longitude != points.lastOrNull?.longitude) {
      return points..add(points.firstOrNull!);
    }
    return points;
  }

  List<Fragment$Coordinate> sanitizedCoordinates(
    List<Fragment$Coordinate>? points,
  ) {
    if (points?.isEmpty ?? true) return [];
    if (points?.firstOrNull?.lat != points?.lastOrNull?.lat ||
        points?.firstOrNull?.lng != points?.lastOrNull?.lng) {
      return points!..add(points.firstOrNull!);
    }
    return points!;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<Fragment$Coordinate>>(
      initialValue: widget.initialValue,
      validator: (value) => widget.validator?.call(value),
      onSaved: (value) => widget.onSaved?.call(
        sanitizedCoordinates(value).map((e) => e.toPointInput()).toList(),
      ),
      builder: (state) {
        final polyEditor = PolyEditor(
          callbackRefresh: (LatLng? latLng) {
            setState(() {});
          },
          points: state.value?.map((e) => e.toLatLngLib()).toList() ?? [],
          pointIconSize: const Size(16, 16),
          intermediateIconSize: const Size(16, 16),
          pointIcon: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primary,
            ),
            child: const Icon(
              BetterIcons.arrowExpandOutline,
              color: Colors.white,
              size: 12,
            ),
          ),
          intermediateIcon: Container(
            width: 16,
            height: 16,
            decoration: ShapeDecoration(
              color: context.colors.primary,
              shape: const OvalBorder(
                side: BorderSide(width: 2, color: Colors.white),
              ),
            ),
          ),
          addClosePathMarker: true,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: AppGenericMap(
                      onControllerReady: (controller) {
                        if (state.value?.isNotEmpty ?? false) {
                          controller.fitBounds(
                            state.value?.map((e) => e.toLatLngLib()).toList() ??
                                [],
                          );
                        }
                      },
                      interactive: true,
                      padding: const EdgeInsets.all(16),
                      hasSearchBar: true,
                      initialLocation: Env.defaultLocation,
                      isPolylineDrawModeEnabled: true,
                      polyEditor: polyEditor,
                      onPolylineDrawn: (p0) {
                        if (history.isNotEmpty) {
                          if (historyIndex.isNotEmpty) {
                            if (historyIndex.last < history.length - 1) {
                              history.removeRange(
                                historyIndex.last + 1,
                                history.length,
                              );
                            }
                          }
                        }
                        if (history.length >= historyLimit) {
                          history.removeAt(0);
                        }
                        history.add(p0.toFragmentCoordinateList());
                        historyIndex.add(history.length - 1);
                        widget.onChanged?.call(p0.toPointInputList());
                        state.didChange(p0.toFragmentCoordinateList());
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 64, right: 16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [kShadow12(context)],
                      ),
                      child: Row(
                        spacing: 8,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextButton(
                            size: ButtonSize.medium,
                            prefixIcon: BetterIcons.delete03Outline,
                            color: SemanticColor.error,
                            onPressed: () {
                              for (
                                var i = polyEditor.points.length - 1;
                                i >= 0;
                                i--
                              ) {
                                polyEditor.remove(i);
                              }
                              // polyEditor.points.clear();
                              widget.onChanged?.call([]);
                              state.didChange([]);
                            },
                            text: context.tr.clear,
                          ),
                          AppTooltip(
                            size: TooltipSize.large,
                            title: context.tr.tips,
                            subtitle: context.tr.geofenceTips,
                            trigger: TooltipTrigger.hover,
                            child: AppTextButton(
                              size: ButtonSize.medium,
                              prefixIcon: BetterIcons.helpCircleOutline,
                              onPressed: () {
                                // Should be empty, the wrapping tooltip would show the tips
                              },
                              text: context.tr.tips,
                            ),
                          ),
                          // AppTextButton(
                          //   size: ButtonSize.medium,
                          //   prefixIcon: BetterIcons.arrowTurnBackwardOutline,
                          //   color: SemanticColor.neutral,
                          //   isDisabled: history.isEmpty ||
                          //       historyIndex.isEmpty ||
                          //       historyIndex.last == 0,
                          //   onPressed: () {
                          //     if (polyEditor.points.isEmpty) return;
                          //     if (history.isEmpty) return;
                          //     if (historyIndex.isEmpty) return;
                          //     if (historyIndex.last == 0) return;
                          //     if (historyIndex.last > 0) {
                          //       historyIndex.last--;
                          //     }
                          //     polyEditor.points.clear();
                          //     polyEditor.points.addAll(
                          //       history[historyIndex.last]
                          //           .map((e) => e.toLatLngLib())
                          //           .toList(),
                          //     );
                          //     widget.onChanged?.call(
                          //       history[historyIndex.last]
                          //           .map((e) => e.toPointInput())
                          //           .toList(),
                          //     );
                          //     state.didChange(
                          //       history[historyIndex.last].toList(),
                          //     );
                          //     setState(() {});
                          //   },
                          //   text: context.translate.undo,
                          // ),
                          // AppTextButton(
                          //   size: ButtonSize.medium,
                          //   prefixIcon: BetterIcons.arrowTurnForwardOutline,
                          //   color: SemanticColor.neutral,
                          //   onPressed: () {
                          //     if (polyEditor.points.isEmpty) return;
                          //     if (history.isEmpty) return;
                          //     if (historyIndex.isEmpty) return;
                          //     if (historyIndex.last >= history.length - 1) {
                          //       return;
                          //     }
                          //     if (historyIndex.last < history.length - 1) {
                          //       historyIndex.last++;
                          //     }
                          //     polyEditor.points.clear();
                          //     polyEditor.points.addAll(
                          //       history[historyIndex.last]
                          //           .map((e) => e.toLatLngLib())
                          //           .toList(),
                          //     );
                          //     widget.onChanged?.call(
                          //       history[historyIndex.last]
                          //           .map((e) => e.toPointInput())
                          //           .toList(),
                          //     );
                          //     state.didChange(
                          //       history[historyIndex.last].toList(),
                          //     );
                          //     setState(() {});
                          //   },
                          //   isDisabled: historyIndex.isEmpty ||
                          //       historyIndex.last >= history.length - 1,
                          //   text: context.translate.redo,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                state.errorText!,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
