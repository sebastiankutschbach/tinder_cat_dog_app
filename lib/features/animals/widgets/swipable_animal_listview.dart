import 'package:flutter/material.dart';

typedef LikedCallback = void Function(int index, bool isLiked);

class SwipableAnimalListview extends StatelessWidget {
  const SwipableAnimalListview({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onLikedItem,
  }) : super(key: key);

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final LikedCallback onLikedItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey('animal-${index % itemCount}'),
          child: SizedBox(
            height: constraints.maxHeight,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: itemBuilder(context, index % itemCount),
              ),
            ),
          ),
          onDismissed: (direction) {
            onLikedItem(index, direction == DismissDirection.endToStart);
          },
        ),
      ),
    );
  }
}
