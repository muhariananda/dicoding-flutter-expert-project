import 'package:flutter_test/flutter_test.dart';
import 'package:movie_core/movie_core.dart';

void main() {
  const tGenreModel = GenreModel(
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
