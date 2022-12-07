import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'watchlist_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetWatchListTvSeries])
void main() {
  late WatchlistTvSeriesCubit cubit;
  late MockGetWatchListTvSeries mockGetWatchListTvSeries;

  setUp(() {
    mockGetWatchListTvSeries = MockGetWatchListTvSeries();
    cubit = WatchlistTvSeriesCubit(
      getWatchListTvSeries: mockGetWatchListTvSeries,
    );
  });

  group('Get watchlist tv series,', () {
    test('initial state should be [WatchlistTvSeriesInProgress]', () {
      expect(cubit.state, WatchlistTvSeriesInProgress());
    });

    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'should emit [WatchlistTvSeriesSuccess] when data is gotten successfully',
      build: () {
        when(mockGetWatchListTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistTvSeries(),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesSuccess(tvSeries: testTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetWatchListTvSeries.execute());
      },
    );

    blocTest<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      'should emit [WatchlistTvSeriesFailure] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchListTvSeries.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistTvSeries(),
      expect: () => <WatchlistTvSeriesState>[
        WatchlistTvSeriesFailure(message: 'Failure'),
      ],
      verify: (_) {
        verify(mockGetWatchListTvSeries.execute());
      },
    );
  });
}
