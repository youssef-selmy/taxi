/// Permission Orchestrator - Shared permission handling for Flutter apps.
///
/// Provides a unified API for managing permissions with:
/// - Event-based checks at critical user flow points
/// - Context-aware rationale dialogs
/// - Settings redirect for permanently denied permissions
/// - Dismissal tracking with cooldown to avoid over-prompting
library permission_orchestrator;

// Models
export 'src/models/permission_type.dart';
export 'src/models/permission_status.dart';
export 'src/models/permission_request_result.dart';

// Service
export 'src/service/permission_service.dart';
export 'src/service/permission_service_impl.dart';

// Widgets
export 'src/widgets/permission_gate.dart';
export 'src/widgets/permission_rationale_dialog.dart';
export 'src/widgets/permission_settings_dialog.dart';

// Utils
export 'src/utils/platform_utils.dart';
