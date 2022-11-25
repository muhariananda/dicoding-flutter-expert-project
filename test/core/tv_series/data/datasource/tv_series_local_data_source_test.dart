import 'package:ditonton/common/exception.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/tv_series/dummy_tv_series.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvSeriesLocalDataSourceImpl datasource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    datasource =
        TvSeriesLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save tv series watchlist', () {
    test(
      'should return success message when insert to database is success',
      () async {
        //arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 1);

        //act
        final result =
            await datasource.insertTvSeriesWatchlist(testTvSeriesTable);

        //assert
        expect(result, 'Added to watchlist');
      },
    );

    test(
      'should retrun DatabseException when insert to database is failed',
      () async {
        //arrange
        when(mockDatabaseHelper.insertTvSeriesWatchlist(testTvSeriesTable))
            .thenThrow(Exception);

        //act
        final call = datasource.insertTvSeriesWatchlist(testTvSeriesTable);

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
        when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 1);

        //act
        final result =
            await datasource.removeTvSeriesWatchlist(testTvSeriesTable);

        //assert
        expect(result, 'Removed from watchlist');
      },
    );

    test(
      'should return DatabaseException when remove from database is failed',
      () async {
        //arrange
        when(mockDatabaseHelper.removeTvSeriesWatchlist(testTvSeriesTable))
            .thenThrow(Exception());

        //act
        final call = datasource.removeTvSeriesWatchlist(testTvSeriesTable);

        //assert
        expect(() => call, throwsA(isA<DatabaseException>()));
      },
    );
  });

  group('get tv series by id', () {
    final tId = 1;

    test('should return Tv Series Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.getTvSeriesById(tId))
          .thenAnswer((_) async => testTvSeriesMap);

      //act
      final result = await datasource.getTvSeriesById(tId);

      //assert
      expect(result, testTvSeriesTable);
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
          .thenAnswer((_) async => [testTvSeriesMap]);

      //act
      final result = await datasource.getWatchlistTvSeries();

      //assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
