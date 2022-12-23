import 'package:db_sqflite/db_sqflite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tMapTvSeriesTable = {
    'id': 1,
    'name': 'name',
    'posterPath': 'posterPath',
    'overview': 'overview',
  };

  test('should convert from table to map', () {
    final result = tTvSeriesTable.toJson();
    expect(result, tMapTvSeriesTable);
  });

  test('should convert from map to table', () {
    final result = TvSeriesTable.fromJson(tMapTvSeriesTable);
    expect(result, tTvSeriesTable);
  });
}
