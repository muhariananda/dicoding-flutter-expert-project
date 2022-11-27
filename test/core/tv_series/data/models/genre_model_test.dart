import 'package:ditonton/core/tv_series/data/models/genre_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenreModel = GenreModel(id: 1, name: 'name');

  final tMapGenreModel = {
    'id': 1,
    'name': 'name',
  };

  test('should convert to json from genre model', () {
    final result = tGenreModel.toJson();
    expect(result, tMapGenreModel);
  });
}
