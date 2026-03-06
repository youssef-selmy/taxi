// This class defines an option for a Toggle Switch Button Group.
part of 'toggle_switch_button_group.dart';

class ToggleSwitchButtonGroupOption<T> {
  // The label text for the option (if provided).
  final String? label;

  // The icon associated with the option (if provided).
  final IconData? icon;

  // The selected icon to be displayed when this option is selected.
  // This is optional and can be used to show a different icon when selected.
  // If not provided, the default icon will be used.
  final IconData? selectedIcon;

  final T value;

  final int? badge;

  // Constructor ensuring that at least one of label or icon is provided.
  ToggleSwitchButtonGroupOption({
    this.icon,
    this.label,
    this.badge,
    required this.value,
    this.selectedIcon,
  }) : assert(
         label != null || icon != null,
         'Either label or icon must be provided.', // Ensures that at least one property is set.
       );
}
