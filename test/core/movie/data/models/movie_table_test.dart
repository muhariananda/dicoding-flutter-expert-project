import 'package:ditonton/core/movie/data/models/movie_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview,',
  );

  final tMapMovieTable = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview,'
  };

  test('should be map from movie table', () {
    final result = tMovieTable.toJson();
    expect(result, tMapMovieTable);
  });
}
