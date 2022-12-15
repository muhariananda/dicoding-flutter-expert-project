import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_domain/tv_series_domain.dart';
import 'package:watchlist/watchlist.dart';

import '../dummy_data/dummy_tv_series.dart';
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
      expect(cubit.state, const WatchlistTvSeriesInProgress());
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
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistTvSeries(),
      expect: () => <WatchlistTvSeriesState>[
        const WatchlistTvSeriesFailure(message: 'Failure'),
      ],
      verify: (_) {
        verify(mockGetWatchListTvSeries.execute());
      },
    );
  });
}
