import 'package:flutter/material.dart';
import 'package:news/models/article_model.dart';
// import 'package:rxdart/rxdart.dart';

class InterestWidget extends StatefulWidget {
  // final Observable<Article> feedStream;
  final double height;

  InterestWidget(
      {
      //this.feedStream,
      this.height});

  @override
  _InterestWidgetState createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<Article> _list;

  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _list = ListModel<Article>(
      listKey: _listKey,
      removedItemBuilder: _buildRemovedItem,
    );

    // widget.feedStream.listen((data) {

    //   if (!isPaused) {
    //     _list.insert(0, data);
    //     if (_list.length > 3) {
    //       _list.removeAt(_list.length - 1);
    //     }
    //   }
    // });
  }

  // Used to build list items that haven't been removed.
  Widget _buildFeed(
      BuildContext context, int index, Animation<double> animation) {
    return Text("abc");
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(int index, Article item, BuildContext context,
      Animation<double> animation) {
    return Text("abc");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: widget.height,
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildFeed,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override

  // ignore: override_on_non_overriding_member
  void didPopNext() {
    isPaused = false;
  }

  @override
  // ignore: override_on_non_overriding_member
  void didPushNext() {
    isPaused = true;
  }

  @override
  // ignore: override_on_non_overriding_member
  void didPop() {
    isPaused = true;
  }
}

/// Keeps a Dart List in sync with an AnimatedList.
///
/// The [insert] and [removeAt] methods apply to both the internal list and the
/// animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that mutate the
/// list must make the same changes to the animated list in terms of
/// [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(index, removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as the animation varies from 0.0 to 1.0.
