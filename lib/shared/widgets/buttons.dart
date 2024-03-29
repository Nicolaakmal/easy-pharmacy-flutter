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

  const CustomButton({
    Key? key,
    required this.buttonType,
    this.label,
    this.icon,
    this.onPressed,
    this.dropdownItems,
    this.onToggle,
    this.isToggled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (buttonType) {
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          child: Text(label ?? ''),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          child: Text(label ?? ''),
        );
      case ButtonType.outlined:
        return OutlinedButton(
          onPressed: onPressed,
          child: Text(label ?? ''),
        );
      case ButtonType.icon:
        return IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        );
      case ButtonType.floating:
        return FloatingActionButton(
          onPressed: onPressed,
          child: Icon(icon),
        );
      case ButtonType.dropdown:
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
