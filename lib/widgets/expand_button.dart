import 'package:flutter/material.dart';

class ExpandableListTile extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const ExpandableListTile({
    required this.title,
    required this.children,
  });

  @override
  _ExpandableListTileState createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.title),
          trailing: _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Column(
            children: widget.children,
          ),
      ],
    );
  }
}
