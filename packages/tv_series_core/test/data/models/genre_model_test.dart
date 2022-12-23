import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_core/tv_series_core.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  final tMapGenreModel = {
    'id': 1,
    'name': 'name',
  };

  test('should convert to json from genre model', () {
    final result = tGenreModel.toJson();
    expect(result, tMapGenreModel);
  });
}
