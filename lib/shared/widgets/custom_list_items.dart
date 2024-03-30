import 'package:flutter/material.dart';

enum ListItemType { basic, icon, avatar, actionable, switchItem }

class CustomListItem extends StatefulWidget {
  final ListItemType itemType;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback? onTap;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const CustomListItem({
    Key? key,
    required this.itemType,
    required this.title,
    this.subtitle,
    this.icon,
    this.imagePath,
    this.onTap,
    this.switchValue,
    this.onSwitchChanged,
  }) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    if (widget.switchValue != null) {
      _switchValue = widget.switchValue!;
    }
  }

  Widget _buildLeading() {
    switch (widget.itemType) {
      case ListItemType.icon:
        return Icon(widget.icon);
      case ListItemType.avatar:
        return CircleAvatar(
          backgroundImage: AssetImage(widget.imagePath!),
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildTrailing() {
    switch (widget.itemType) {
      case ListItemType.actionable:
        return IconButton(
          icon: Icon(widget.icon),
          onPressed: widget.onTap,
        );
      case ListItemType.switchItem:
        return Switch(
          value: _switchValue,
          onChanged: (bool value) {
            setState(() {
              _switchValue = value;
            });
            if (widget.onSwitchChanged != null) {
              widget.onSwitchChanged!(value);
            }
          },
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(),
      title: Text(widget.title),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      trailing: _buildTrailing(),
      onTap: widget.itemType == ListItemType.basic ? widget.onTap : null,
    );
  }
}
