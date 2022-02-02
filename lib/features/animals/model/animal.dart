import 'package:equatable/equatable.dart';

abstract class Animal extends Equatable {
  final String id;
  final String name;
  final String path;

  Animal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'] ?? "N/A",
        path = json['path'];

  @override
  List<Object?> get props => [id, name, path];
}
