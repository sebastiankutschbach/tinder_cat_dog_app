import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinder_cat_dog_app/features/animals/model/animal.dart';
import 'package:tinder_cat_dog_app/features/animals/model/cat.dart';
import 'package:tinder_cat_dog_app/features/animals/model/dog.dart';
import 'package:tinder_cat_dog_app/features/animals/model/failure.dart';

const String apiBaseUrl = 'https://tinder-cat-dog-api.herokuapp.com';

class AnimalsRepository {
  final Dio _dio;

  AnimalsRepository(this._dio) {
    _dio.options.baseUrl = apiBaseUrl;
    _dio.options.headers[Headers.acceptHeader] = Headers.jsonContentType;
    _dio.options.headers[Headers.contentTypeHeader] = Headers.jsonContentType;
  }

  Future<void> authorize() async {
    final response = await _dio.post('/auth');
    _dio.options.headers['Authorization'] = response.headers['Authorization'];
  }

  Future<Either<Failure, List<Animal>>> getCats() async {
    try {
      final response = await _dio.get('/cats');
      final cats = List<Cat>.from(response.data.map((json) {
        log(json.toString());
        return Cat.fromJson(json);
      }));
      return right(cats);
    } on DioError catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Either<Failure, List<Animal>>> getDogs() async {
    try {
      final response = await _dio.get('/dogs');
      final dogs = List<Dog>.from(response.data.map((json) {
        log(json.toString());
        return Dog.fromJson(json);
      }));
      return right(dogs);
    } on DioError catch (e) {
      return left(Failure(e.message));
    }
  }

  Future<Option<Failure>> vote(Animal animal, bool isLiked) async {
    try {
      log(_dio.options.headers['Authorization'].toString());
      final data = {
        "vote_type": animal is Cat ? "cat" : "dog",
        "animal_id": animal.id,
        "liked": isLiked
      };
      log(data.toString());
      final result = await _dio.post('/votes', data: data);
      log(result.toString());
      return none();
    } on DioError catch (e) {
      return some(Failure(e.message));
    }
  }
}
