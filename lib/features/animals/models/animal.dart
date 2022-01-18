import 'package:tinder_cat_dog_app/features/animals/models/animal_type.dart';

class Animal {
  final AnimalType type;
  final String name;
  final String path;

  Animal({
    required this.type,
    required this.name,
    required this.path,
  });
}
