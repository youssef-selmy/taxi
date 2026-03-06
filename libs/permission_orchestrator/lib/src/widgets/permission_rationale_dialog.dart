import 'package:flutter/material.dart';

/// Dialog that explains why a permission is needed before requesting it.
///
/// Shows a title, description, icon, and two buttons:
/// - Primary button to proceed with the permission request
/// - Secondary button to dismiss without requesting
class PermissionRationaleDialog extends StatelessWidget {
  /// Title of the dialog.
  final String title;

  /// Description explaining why the permission is needed.
  final String description;

  /// Icon shown at the top of the dialog.
  final IconData icon;

  /// Text for the primary action button.
  final String primaryButtonText;

  /// Text for the secondary/cancel button.
  final String secondaryButtonText;

  const PermissionRationaleDialog({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.info_outline,
    this.primaryButtonText = 'Allow',
    this.secondaryButtonText = 'Not now',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(primaryButtonText),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(secondaryButtonText),
            ),
          ),
        ],
      ),
    );
  }
}
