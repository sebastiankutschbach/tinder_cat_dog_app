import 'package:flutter/material.dart';

/// This page shows the different settings for the
/// user.
///
/// Your task is to put the users selection to your BLoC and load the cats or
/// the dogs from the server based on that.
class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('Cats'),
          Switch(
            value: false,
            onChanged: (value) {},
          ),
          const Text('Dogs'),
        ],
      ),
    );
  }
}
