import 'package:flutter/material.dart';

/// A Callback that is called every time the user swipes the list item.
/// [isLiked] is true when the user swiped to the right and false otherwise.
typedef LikedCallback = void Function(int index, bool isLiked);

/// A List view widget that makes provides a swipable item through
/// the [itemBuilder]. The item fills up the whole screen.
/// The list is not scrollable.
/// It can display [itemCount] number of items. It continously displays the items.
class SwipableListview extends StatelessWidget {
  const SwipableListview({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLikedItem,
  }) : super(key: key);

  /// The number of items to display.
  final int itemCount;

  /// The builder, which provides the content for each item.
  final IndexedWidgetBuilder itemBuilder;

  /// This callback is executed on every swipe.
  final LikedCallback onLikedItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey('item-${index % itemCount}'),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: itemBuilder(context, index % itemCount),
              ),
            ),
          ),
          onDismissed: (direction) {
            onLikedItem(index % itemCount, direction == DismissDirection.startToEnd);
          },
        ),
      ),
    );
  }
}
