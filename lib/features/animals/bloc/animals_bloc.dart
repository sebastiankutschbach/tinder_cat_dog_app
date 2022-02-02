import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinder_cat_dog_app/features/animals/data/animals_repository.dart';
import 'package:tinder_cat_dog_app/features/animals/model/animal.dart';
import 'package:tinder_cat_dog_app/features/animals/model/failure.dart';

part 'animals_event.dart';
part 'animals_state.dart';

class AnimalsBloc extends Bloc<AnimalsEvent, AnimalsState> {
  final AnimalsRepository _animalsRepo;

  AnimalsBloc(this._animalsRepo) : super(AnimalsInitial()) {
    on<LoginRequested>((event, emit) async {
      await _animalsRepo.authorize();
    });
    on<AnimalsRequested>((event, emit) async {
      emit(AnimalsLoading());
      final response = await _animalsRepo.getCats();

      response.fold((failure) => emit(AnimalsError(failure)),
          (animals) => emit(AnimalsLoaded(animals)));
    });

    on<AnimalVoted>((event, emit) async {
      await _animalsRepo.vote(event.animal, event.isLiked);
    });
  }
}
