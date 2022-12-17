import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_repository/src/models/genre_model.dart';

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
