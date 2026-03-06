import 'package:flutter/material.dart';

/// Dialog that guides users to app settings when permission is permanently denied.
///
/// Shows explanation and provides a button to open system settings.
class PermissionSettingsDialog extends StatelessWidget {
  /// Title of the dialog.
  final String title;

  /// Description explaining how to enable the permission in settings.
  final String description;

  /// Text for the open settings button.
  final String openSettingsText;

  /// Text for the cancel button.
  final String cancelText;

  /// Callback that opens the appropriate settings page.
  /// Should return true if settings were opened successfully.
  final Future<bool> Function() onOpenSettings;

  const PermissionSettingsDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onOpenSettings,
    this.openSettingsText = 'Open Settings',
    this.cancelText = 'Cancel',
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
              color: colorScheme.errorContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.settings,
              size: 32,
              color: colorScheme.onErrorContainer,
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
              onPressed: () async {
                final opened = await onOpenSettings();
                if (context.mounted) {
                  Navigator.of(context).pop(opened);
                }
              },
              child: Text(openSettingsText),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelText),
            ),
          ),
        ],
      ),
    );
  }
}
