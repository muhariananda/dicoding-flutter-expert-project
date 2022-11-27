import 'package:ditonton/core/movie/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  final tMapGenreModel = {
    'id': 1,
    'name': 'name',
  };

  test('should to json from genre model class', () {
    final result = tGenreModel.toJson();
    expect(tMapGenreModel, result);
  });
}
