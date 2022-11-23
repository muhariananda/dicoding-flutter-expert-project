import 'package:dartz/dartz.dart';
import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:ditonton/features/watchlist/watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie/dummy_movie.dart';
import '../../dummy_data/tv_series/dummy_tv_series.dart';
import 'watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchListTvSeries])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    provider = WatchlistNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
      getWatchListTvSeries: mockGetWatchListTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('get movies watchlist,', () {
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));

      // act
      await provider.fetchWatchlistMovies();

      // assert
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.watchlistMovies, [testWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Cannot get data')));

      // act
      await provider.fetchWatchlistMovies();

      // assert
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Cannot get data');
      expect(listenerCallCount, 2);
    });
  });

  group('get tv series watchlist,', () {
    test(
        'should change list of tv series data when the data is gotten successfully',
        () async {
      //arrange
      when(mockGetWatchListTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchWatchlistTvSeries();

      //assert
      verify(mockGetWatchListTvSeries.execute());
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.watchlistTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetWatchListTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Cannot get data')));

      //act
      await provider.fetchWatchlistTvSeries();

      //assert
      verify(mockGetWatchListTvSeries.execute());
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Cannot get data');
      expect(listenerCallCount, 2);
    });
  });

  test('selected content should change', () {
    provider.setSelectedContent(ContentSelection.tv);
    expect(provider.contentSelection, ContentSelection.tv);
  });
}
