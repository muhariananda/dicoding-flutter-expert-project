import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:ditonton/feature/tvseries/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetWatchListTvSeries])
void main() {
  late WatchlistTvSeriesNotifier provider;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    provider = WatchlistTvSeriesNotifier(
        getWatchListTvSeries: mockGetWatchListTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('get watchlist tv series,', () {
    test('initial state should be empty', () {
      expect(provider.watchlistState, RequestState.Empty);
    });

    test('should change watchlist data when data is gotten successfully',
        () async {
      //arrange
      when(mockGetWatchListTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchWatchlistTvSeries();

      //assert
      verify(mockGetWatchListTvSeries.execute());
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should change error message when data is gotten unsuccessful',
        () async {
      //arrange
      when(mockGetWatchListTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Cannot get data')));

      //act
      await provider.fetchWatchlistTvSeries();

      //assert
      verify(mockGetWatchListTvSeries.execute());
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, 'Cannot get data');
      expect(listenerCallCount, 2);
    });
  });
}
