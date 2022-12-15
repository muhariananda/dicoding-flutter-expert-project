import 'package:common/common.dart';
import 'package:db_sqflite/db_sqflite.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_repository/tv_series_repository.dart';

import '../test_helper/test_helper.mocks.dart';

void main() {
  late TvSeriesLocalDataSourceImpl datasource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    datasource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  const tTvSeriesTable = TvSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
  );

  final tTvSeriesMap = {
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'posterPath': 'posterPath',
  };

  group('save tv series watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        //arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(tTvSeriesTable))
            .thenAnswer((_) async => 1);

        //act
        final result =
            await datasource.insertTvSeriesWatchlist(tTvSeriesTable);

        //assert
        expect(result, 'Added to watchlist');
      },
    );

    test(
      'should retrun DatabseException when insert to database is failed',
      () async {
        //arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(tTvSeriesTable))
            .thenThrow(Exception);

        //act
        final call = datasource.insertTvSeriesWatchlist(tTvSeriesTable);

        //assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('remove tv series watchlist', () {
    test(
      'should return success message when remove from database is success',
      () async {
        //arrange
        when(mockDatabaseHelper.removeTvSeriesWatchlist(tTvSeriesTable))
            .thenAnswer((_) async => 1);

        //act
        final result =
            await datasource.removeTvSeriesWatchlist(tTvSeriesTable);

        //assert
        expect(result, 'Removed from watchlist');
      },
    );

    test(
      'should return DatabaseException when remove from database is failed',
      () async {
        //arrange
        when(mockDatabaseHelper.removeTvSeriesWatchlist(tTvSeriesTable))
            .thenThrow(Exception());

        //act
        final call = datasource.removeTvSeriesWatchlist(tTvSeriesTable);

        //assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('get tv series by id', () {
    const tId = 1;

    test('should return Tv Series Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => tTvSeriesMap);

      //act
      final result = await datasource.getTvSeriesById(tId);

      //assert
      expect(result, tTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      //arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      //act
      final result = await datasource.getTvSeriesById(tId);

      //assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list Tv Series Table from database', () async {
      //arrange
      when(mockDatabaseHelper.getWatchlistTvSeries())
          .thenAnswer((_) async => [tTvSeriesMap]);

      //act
      final result = await datasource.getWatchlistTvSeries();

      //assert
      expect(result, [tTvSeriesTable]);
    });
  });
}
