import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/theme/shadows.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class EcommerceCustomerInfoCard extends StatelessWidget {
  const EcommerceCustomerInfoCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: _cardDecoration(context),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomerHeader(context),
          AppDivider(),
          isMobile
              ? _buildShippingSection(context)
              : _buildDesktopShippingSection(context),
          AppDivider(),
          _buildPaymentSection(context),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration(BuildContext context) => BoxDecoration(
    color: context.colors.surface,
    border: Border.all(color: context.colors.outline),
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BetterShadow.shadow4.toBoxShadow(context)],
  );

  Widget _buildCustomerHeader(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 8,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Assets.images.avatars.illustration01.image(
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                spacing: 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Corey George', style: context.textTheme.bodyMedium),
                  Text(
                    'corey@better.com',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: context.colors.onSurfaceVariantLow,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        _buildInfoRow(context, label: 'IP Address:', value: '192.168.1.1'),
      ],
    );
  }

  Widget _buildShippingSection(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping', style: context.textTheme.labelLarge),
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabeledContent(
              context,
              label: 'Address',
              icon: BetterIcons.location01Outline,
              content: 'Cordova, 3785 Blackwell Street',
            ),
            _buildLabeledContent(
              context,
              label: 'Phone number',
              icon: BetterIcons.call02Outline,
              content: '+1 (888)888-888',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopShippingSection(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shipping', style: context.textTheme.labelLarge),
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: _buildLabeledContent(
                context,
                label: 'Address',
                icon: BetterIcons.location01Outline,
                content: 'Cordova, 3785 Blackwell Street',
              ),
            ),
            Expanded(
              child: _buildLabeledContent(
                context,
                label: 'Phone number',
                icon: BetterIcons.call02Outline,
                content: '+1 (888)888-888',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentSection(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method', style: context.textTheme.labelLarge),
        Row(
          spacing: 8,
          children: [
            ClipRRect(
              child: Assets.images.paymentMethods.mastercardPng.image(
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('MasterCard', style: context.textTheme.labelLarge),
                Text(
                  '**** **** **** 7238',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: context.colors.onSurfaceVariantLow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      spacing: 4,
      children: [
        Text(
          label,
          style: context.textTheme.bodySmall!.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        Text(value, style: context.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildLabeledContent(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String content,
  }) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.textTheme.bodySmall),
        Row(
          spacing: 4,
          children: [
            Icon(icon, color: context.colors.onSurfaceVariant, size: 16),
            Flexible(
              child: Text(
                content,
                style: context.textTheme.bodySmall!.copyWith(
                  color: context.colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
