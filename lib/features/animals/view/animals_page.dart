import 'package:flutter/material.dart';
import 'package:tinder_cat_dog_app/features/animals/animals.dart';
import 'package:tinder_cat_dog_app/features/settings/settings.dart';

class AnimalsPage extends StatelessWidget {
  static const routeName = '/';

  const AnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
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
      body: SwipableAnimalListview(
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
        onLikedItem: (index, isLiked) {},
      ),
    );
  }
}
