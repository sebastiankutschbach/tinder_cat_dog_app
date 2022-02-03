part of 'animals_bloc.dart';

@immutable
abstract class AnimalsState extends Equatable {}

class AnimalsInitial extends AnimalsState {
  @override
  List<Object?> get props => [];
}

class AnimalsLoading extends AnimalsState {
  @override
  List<Object?> get props => [];
}

class AnimalsError extends AnimalsState {
  final Failure failure;

  AnimalsError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class AnimalsLoaded extends AnimalsState {
  final List<Animal> animals;
  final Option<Failure> failure;

  AnimalsLoaded(this.animals, this.failure);

  @override
  List<Object?> get props => [animals, failure];
}
