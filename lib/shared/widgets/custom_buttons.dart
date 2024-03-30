import 'package:flutter/material.dart';

enum ButtonType { elevated, text, outlined, icon, floating, dropdown, toggle }

class CustomButton extends StatelessWidget {
  final ButtonType buttonType;
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final List<String>? dropdownItems;
  final ValueChanged<bool>? onToggle;
  final bool isToggled;
  final Widget? child;

  const CustomButton({
    Key? key,
    required this.buttonType,
    this.label,
    this.icon,
    this.onPressed,
    this.dropdownItems,
    this.onToggle,
    this.isToggled = false,
    this.child,
  }) : super(key: key);

  Widget _buildChild() {
    // Check if there's an icon and label, and build an appropriate child widget.
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon));
      if (label != null) {
        children.add(const SizedBox(width: 8.0)); // Add space between icon and label
      }
    }
    if (label != null) {
      children.add(Text(label!));
    }

    return Row(
      mainAxisSize: MainAxisSize.min, // Use min size that fit child content
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonChild = child ??
        _buildChild(); // Use child if provided, otherwise use _buildChild

    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Set some default padding
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)), // Rounded corners
          ),
          child: buttonChild,
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          child: buttonChild,
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12), // Set some default padding
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)), // Rounded corners
          ),
          child: buttonChild,
        );
      case ButtonType.icon:
        // Ensure that the icon parameter is not null when using ButtonType.icon
        return IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        );
      case ButtonType.floating:
        // Ensure that the icon parameter is not null when using ButtonType.floating
        return FloatingActionButton(
          onPressed: onPressed,
          child: Icon(icon),
        );
      case ButtonType.dropdown:
        // Handle dropdown logic
        return DropdownButton<String>(
          items: dropdownItems?.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        );
      case ButtonType.toggle:
        // Handle toggle logic
        return ToggleButtons(
          children: <Widget>[
            Icon(icon),
          ],
          onPressed: (int index) {
            if (onToggle != null) {
              onToggle!(!isToggled);
            }
          },
          isSelected: [isToggled],
        );
      default:
        return Container(); // Fallback for an undefined button type
    }
  }
}
