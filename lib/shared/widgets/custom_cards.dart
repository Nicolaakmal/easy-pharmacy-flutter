import 'package:flutter/material.dart';

enum CardType { basic, image, actionable, checkable, expandable }

class CustomCard extends StatefulWidget {
  final CardType cardType;
  final String title;
  final String? subtitle;
  final String? imagePath;
  final List<Widget>? actions;
  final Widget? child;
  final bool initiallyExpanded;

  const CustomCard({
    Key? key,
    required this.cardType,
    required this.title,
    this.subtitle,
    this.imagePath,
    this.actions,
    this.child,
    this.initiallyExpanded = false,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool _isExpanded = false;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Widget _buildLeading() {
    switch (widget.cardType) {
      case CardType.checkable:
        return Checkbox(
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value!;
            });
          },
        );
      case CardType.image:
        return widget.imagePath != null
            ? Image.asset(
                widget.imagePath!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            : const SizedBox();
      default:
        return const SizedBox();
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    if (widget.cardType == CardType.actionable && widget.actions != null) {
      return widget.actions!;
    }
    if (widget.cardType == CardType.expandable) {
      return [
        IconButton(
          icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ];
    }
    return [];
  }

  Widget _buildTitleSubtitle() {
    return ListTile(
      title: Text(widget.title),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
      trailing: widget.cardType == CardType.checkable
          ? Icon(_isChecked ? Icons.check_circle : Icons.check_circle_outline)
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: _buildLeading(),
            title: Text(widget.title),
            subtitle: widget.subtitle != null ? Text(widget.subtitle!) : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: _buildActions(context),
            ),
          ),
          if (_isExpanded && widget.child != null) ...[
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: widget.child,
            ),
          ]
        ],
      ),
    );
  }
}
