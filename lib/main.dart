import 'package:flutter/material.dart';
import 'package:tinder_cat_dog_app/features/animals/animals.dart';
import 'package:tinder_cat_dog_app/features/settings/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final List<int> animals = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        AnimalsPage.routeName: (context) => const AnimalsPage(),
        SettingsPage.routeName: (context) => const SettingsPage()
      },
    );
  }
}
