import 'permission_type.dart';

/// Record of when a permission rationale dialog was dismissed.
class DismissalRecord {
  /// The type of permission that was dismissed.
  final PermissionType type;

  /// When the dialog was dismissed.
  final DateTime dismissedAt;

  const DismissalRecord({
    required this.type,
    required this.dismissedAt,
  });

  /// Create from JSON map.
  factory DismissalRecord.fromJson(Map<String, dynamic> json) {
    return DismissalRecord(
      type: PermissionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => PermissionType.notification,
      ),
      dismissedAt: DateTime.parse(json['dismissedAt'] as String),
    );
  }

  /// Convert to JSON map.
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'dismissedAt': dismissedAt.toIso8601String(),
      };

  /// Default cooldown period before showing rationale again.
  static const defaultCooldown = Duration(hours: 24);

  /// Returns true if cooldown has passed and rationale can be shown again.
  bool canShowAgain({Duration cooldown = defaultCooldown}) {
    return DateTime.now().difference(dismissedAt) > cooldown;
  }
}
