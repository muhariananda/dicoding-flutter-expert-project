import 'package:db_sqflite/db_sqflite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tMovieTable = MovieTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tMapMovieTable = {
    'id': 1,
    'title': 'title',
    'posterPath': 'posterPath',
    'overview': 'overview'
  };

  test('should convert from table to map', () {
    final result = tMovieTable.toJson();
    expect(result, tMapMovieTable);
  });

  test('should convert from map to table', () {
    final result = MovieTable.fromMap(tMapMovieTable);
    expect(result, tMovieTable);
  });
}
