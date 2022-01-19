import 'package:flutter/material.dart';
import 'package:tinder_cat_dog_app/features/animals/animals.dart';
import 'package:tinder_cat_dog_app/features/settings/settings.dart';

/// This pages shows a swipable list with the Animals.
/// Your task here is to add your BLoC to this page.
///
/// Your BLoC loads the cats or dogs based on the user preference from the
/// API.
///
/// Feel free to replace the whole page with your own implementation.
class AnimalsPage extends StatelessWidget {
  static const routeName = '/';

  const AnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tinder for Cats and Dogs'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsPage.routeName);
              },
              icon: const Icon(
                Icons.settings,
              ))
        ],
      ),
      body: SwipableListview(
        itemCount: 10,
        itemBuilder: (context, index) => Stack(
          children: [
            const Positioned.fill(
              child: FlutterLogo(),
            ),
            Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.clear),
                    Text(
                      'Animal $index',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const Icon(Icons.favorite),
                  ],
                ))
          ],
        ),
        // This callback is run every time when the user swipes the card.
        // Based on the swipe direction, the value of isLiked contains whether
        // the user liked the animal at the given index or not.

        // You can react to these events in your BLoC.
        onLikedItem: (index, isLiked) {
          print('$index is $isLiked');
        },
      ),
    );
  }
}
