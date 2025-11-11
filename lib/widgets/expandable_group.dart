import 'package:flutter/material.dart';
import 'package:news/base/app_helpers.dart';

class ExpandableGroup extends StatefulWidget {
  final bool isExpanded;
  final Widget header;
  final List<ListTile> items;

  const ExpandableGroup({
    Key key,
    this.isExpanded = false,
    @required this.header,
    @required this.items,
  }) : super(key: key);

  @override
  _ExpandableGroupState createState() => _ExpandableGroupState();
}

class _ExpandableGroupState extends State<ExpandableGroup> {
  bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _updateExpandState(widget.isExpanded);
  }

  void _updateExpandState(bool isExpanded) =>
      setState(() => _isExpanded = isExpanded);

  @override
  Widget build(BuildContext context) {
    printDebug('Test build ExpandableGroup');
    return _isExpanded ? _buildListItems(context) : _wrapHeader();
  }

  Widget _wrapHeader() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: widget.header,
      trailing: _isExpanded
          ? Icon(
              Icons.keyboard_arrow_up,
              color: Theme.of(context).primaryColor,
            )
          : widget.items.isNotEmpty
              ? Icon(Icons.keyboard_arrow_right)
              : Offstage(),
      onTap: () => _updateExpandState(!_isExpanded),
    );
  }

  Widget _buildListItems(BuildContext context) {
    List<Widget> listTitle = [];
    listTitle.add(_wrapHeader());
    listTitle.addAll(widget.items);

    return Column(children: listTitle);
  }
}
