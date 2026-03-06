import 'package:better_assets/assets.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/better_design_system.dart';
import 'package:flutter/material.dart';

class SwitchToggleServiceSelectorCard extends StatefulWidget {
  const SwitchToggleServiceSelectorCard({super.key});

  @override
  State<SwitchToggleServiceSelectorCard> createState() =>
      _SwitchToggleServiceSelectorCardState();
}

class _SwitchToggleServiceSelectorCardState
    extends State<SwitchToggleServiceSelectorCard> {
  final List<String> services = ['Ride', 'Bike', 'Truck'];

  String selectedService = 'Ride';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 385,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppToggleSwitchButtonGroup<String>(
              isExpanded: true,

              options:
                  services
                      .map(
                        (e) =>
                            ToggleSwitchButtonGroupOption(value: e, label: e),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  selectedService = value;
                });
              },
              selectedValue: selectedService,
            ),

            Column(
              spacing: 8,
              children: [
                _buildServiceItem(
                  context,
                  image: Assets.images.cars.carYellow,
                  title: 'Economy',
                  subtitle: 'Regular taxi',
                  price: '\$12.86',
                ),
                _buildServiceItem(
                  context,
                  image: Assets.images.cars.carWhite,
                  title: 'Comfort',
                  subtitle: 'Regular taxi',
                  price: '\$15.53',
                ),
                _buildServiceItem(
                  context,
                  image: Assets.images.cars.carBlack,
                  title: 'Premium',
                  subtitle: 'Regular taxi',
                  price: '\$22.51',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context, {
    required AssetGenImage image,
    required String title,
    required String subtitle,
    required String price,
  }) => Container(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: context.colors.surface,
      border: Border.all(color: context.colors.outline),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 12,
          children: [
            image.image(width: 40, height: 40),
            Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.labelLarge),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.variant(context),
                ),
              ],
            ),
          ],
        ),
        Text(
          price,
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colors.primary,
          ),
        ),
      ],
    ),
  );
}
