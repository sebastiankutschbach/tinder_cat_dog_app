import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_cat_dog_app/features/animals/animals.dart';
import 'package:tinder_cat_dog_app/features/animals/bloc/animals_bloc.dart';
import 'package:tinder_cat_dog_app/features/animals/cubit/settings_cubit.dart';
import 'package:tinder_cat_dog_app/features/animals/data/animals_repository.dart';
import 'package:tinder_cat_dog_app/features/settings/settings.dart';

void main() {
  BlocOverrides.runZoned(() async {
    runApp(MyApp());
  }, blocObserver: GlobalBlocObserver());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final List<int> animals = List.generate(10, (index) => index);

  @override
  Widget build(BuildContext context) {
    final SettingsCubit settingsCubit = SettingsCubit();
    final animalsRepo = AnimalsRepository(Dio());
    final animalsBloc = AnimalsBloc(animalsRepo, settingsCubit)
      ..add(LoginRequested())
      ..add(AnimalsRequested());
    return BlocProvider(
      create: (context) => settingsCubit,
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          AnimalsPage.routeName: (context) => BlocProvider<AnimalsBloc>(
                create: (_) => animalsBloc,
                child: const AnimalsPage(),
              ),
          SettingsPage.routeName: (context) => const SettingsPage()
        },
      ),
    );
  }
}

class GlobalBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}');
  }
}
