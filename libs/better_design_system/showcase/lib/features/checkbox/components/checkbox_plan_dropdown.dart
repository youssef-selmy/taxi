import 'package:better_design_system/atoms/checkbox/checkbox.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class CheckboxPlanDropdown extends StatefulWidget {
  const CheckboxPlanDropdown({super.key});

  @override
  State<CheckboxPlanDropdown> createState() => _CheckboxPlanDropdownState();
}

class _CheckboxPlanDropdownState extends State<CheckboxPlanDropdown> {
  final OverlayPortalController controller = OverlayPortalController();
  final LayerLink layerLink = LayerLink();
  final GlobalKey _containerKey = GlobalKey();
  bool isExpanded = true;

  List<String> selectedItem = ['Free'];

  void onItemSelected(String value) {
    if (selectedItem.contains(value)) {
      selectedItem.removeWhere((element) => element == value);
    } else {
      setState(() {
        selectedItem.add(value);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.show();
      setState(() {
        isExpanded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      key: _containerKey,
      controller: controller,
      overlayChildBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.hide();
            setState(() {
              isExpanded = false;
            });
          },
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, 8),
            followerAnchor: Alignment.topLeft,
            targetAnchor: Alignment.bottomLeft,
            child: Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 250,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: context.colors.outline),
                    boxShadow: [
                      BoxShadow(
                        color: context.colors.shadow,
                        offset: const Offset(0, 12),
                        blurRadius: 24,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildMenuItem(
                        context,
                        'Free',
                        BetterIcons.manFilled,
                        selectedItem.contains('Free'),
                        (_) {
                          onItemSelected('Free');
                          controller.toggle();
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                      AppDivider(height: 28),
                      _buildMenuItem(
                        context,
                        'Team',
                        BetterIcons.userGroup03Filled,
                        selectedItem.contains('Team'),
                        (_) {
                          onItemSelected('Team');
                          controller.toggle();
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                      AppDivider(height: 28),
                      _buildMenuItem(
                        context,
                        'Enterprise',
                        BetterIcons.building02Filled,
                        selectedItem.contains('Enterprise'),
                        (_) {
                          onItemSelected('Enterprise');
                          controller.toggle();
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          controller.toggle();
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        splashFactory: NoSplash.splashFactory,
        child: CompositedTransformTarget(
          link: layerLink,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Plan',
                  style: context.textTheme.bodyMedium?.variant(context),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  duration: kThemeAnimationDuration,
                  turns: isExpanded ? 0.5 : 0,
                  child: Icon(
                    BetterIcons.arrowDown01Outline,
                    size: 20,
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    bool isSelected,
    void Function(bool)? onChanged,
  ) {
    return InkWell(
      onTap: () {
        controller.hide();
        setState(() {
          isExpanded = false;
        });
      },
      borderRadius: BorderRadius.circular(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: context.colors.surfaceVariant,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              Text(title, style: context.textTheme.labelLarge),
            ],
          ),
          AppCheckbox(value: isSelected, onChanged: onChanged),
        ],
      ),
    );
  }
}
