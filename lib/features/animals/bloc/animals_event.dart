part of 'animals_bloc.dart';

@immutable
abstract class AnimalsEvent {}

class LoginRequested extends AnimalsEvent {}

class AnimalsRequested extends AnimalsEvent {}

class AnimalVoted extends AnimalsEvent {
  final Animal animal;
  final bool isLiked;

  AnimalVoted(this.animal, this.isLiked);
}
