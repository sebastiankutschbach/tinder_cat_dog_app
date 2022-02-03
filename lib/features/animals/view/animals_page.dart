import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_cat_dog_app/features/animals/animals.dart';
import 'package:tinder_cat_dog_app/features/animals/bloc/animals_bloc.dart';
import 'package:tinder_cat_dog_app/features/animals/data/animals_repository.dart';
import 'package:tinder_cat_dog_app/features/settings/settings.dart';

class AnimalsPage extends StatelessWidget {
  static const routeName = '/';

  const AnimalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnimalsBloc, AnimalsState>(
      listener: (context, state) {
        if (state is AnimalsError) {
          _showSnackbar(context, state.failure.message);
        } else if (state is AnimalsLoaded) {
          state.failure.fold(
              () => {}, (failure) => _showSnackbar(context, failure.message));
        }
      },
      builder: (context, state) {
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
            body: _body(context, state));
      },
    );
  }

  _body(BuildContext context, AnimalsState state) {
    switch (state.runtimeType) {
      case AnimalsError:
        return _errorView(context, state as AnimalsError);
      case AnimalsLoading:
        return _loadingView(context, state);
      case AnimalsLoaded:
        if ((state as AnimalsLoaded).animals.isEmpty) {
          return _emptyView(context, state);
        } else {
          return _listView(context, state);
        }
    }
  }

  _errorView(BuildContext context, AnimalsError state) => Center(
        child: Text('An error occured: ${state.failure.message}'),
      );

  _loadingView(BuildContext context, AnimalsState state) => const Center(
        child: CircularProgressIndicator(),
      );

  _emptyView(BuildContext context, AnimalsState state) => const Center(
        child: Text('There are currently no animals to vote.'),
      );

  _listView(BuildContext context, AnimalsLoaded state) => SwipableListview(
        itemCount: state.animals.length,
        itemBuilder: (context, index) => Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: '$apiBaseUrl/${state.animals[index].path}',
              ),
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
                      state.animals[index].name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const Icon(Icons.favorite),
                  ],
                ))
          ],
        ),
        onLikedItem: (index, isLiked) {
          log('$index is $isLiked');
          context
              .read<AnimalsBloc>()
              .add(AnimalVoted(state.animals[index], isLiked));
        },
      );

  _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
