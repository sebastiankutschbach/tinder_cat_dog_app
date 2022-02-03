import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tinder_cat_dog_app/features/animals/cubit/settings_cubit.dart';
import 'package:tinder_cat_dog_app/features/animals/data/animals_repository.dart';
import 'package:tinder_cat_dog_app/features/animals/model/animal.dart';
import 'package:tinder_cat_dog_app/features/animals/model/failure.dart';

part 'animals_event.dart';
part 'animals_state.dart';

class AnimalsBloc extends Bloc<AnimalsEvent, AnimalsState> {
  final AnimalsRepository _animalsRepo;
  final SettingsCubit _settingsCubit;

  StreamSubscription? _settingsSubscription;

  AnimalsBloc(this._animalsRepo, this._settingsCubit)
      : super(AnimalsInitial()) {
    _settingsSubscription =
        _settingsCubit.stream.listen((event) => add(AnimalsRequested()));

    on<LoginRequested>((event, emit) async {
      await _animalsRepo.authorize();
    });

    on<AnimalsRequested>((event, emit) async {
      emit(AnimalsLoading());
      Either<Failure, List<Animal>> response;
      if (_settingsCubit.state.dogsPreferred) {
        response = await _animalsRepo.getDogs();
      } else {
        response = await _animalsRepo.getCats();
      }

      response.fold((failure) => emit(AnimalsError(failure)),
          (animals) => emit(AnimalsLoaded(animals, none())));
    });

    on<AnimalVoted>((event, emit) async {
      final result = await _animalsRepo.vote(event.animal, event.isLiked);

      if (result.isNone()) {
        final animals = List<Animal>.from((state as AnimalsLoaded).animals);
        animals.remove(event.animal);
        emit(AnimalsLoaded(animals, result));
      } else {
        emit(AnimalsLoaded((state as AnimalsLoaded).animals, result));
      }
    });
  }

  @override
  Future<void> close() {
    _settingsSubscription?.cancel();
    return super.close();
  }
}
