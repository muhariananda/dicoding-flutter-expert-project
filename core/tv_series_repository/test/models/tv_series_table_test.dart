import 'package:db_sqflite/db_sqflite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesTable = TvSeriesTable(
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

  test('should convert to json from tv series table', () {
    final result = tTvSeriesTable.toJson();
    expect(result, tMapTvSeriesTable);
  });
}
