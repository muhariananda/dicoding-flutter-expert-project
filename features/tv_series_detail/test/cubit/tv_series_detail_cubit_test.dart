import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_tv_series.dart';
import 'tv_series_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
  GetWatchlistStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailCubit cubit;
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    cubit = TvSeriesDetailCubit(
      getDetailTvSeries: mockGetDetailTvSeries,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  group('Get tv series detail,', () {
    const tId = 1;
    const tTvSeriesDetailState = TvSeriesDetailState();

    test('initial state should be [MovieDetailState]', () {
      expect(cubit.state, const TvSeriesDetailState());
    });

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with tv series data when data is gotten successfully',
      build: () {
        when(mockGetDetailTvSeries.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return cubit;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(tId),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(tvSeries: testTvSeriesDetail),
      ],
      verify: (_) {
        verify(mockGetDetailTvSeries.execute(tId));
      },
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with error message when data is gotten unsuccesfull',
      build: () {
        when(mockGetDetailTvSeries.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTvSeriesDetail(tId),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(errorMessage: 'Not found'),
      ],
      verify: (_) {
        verify(mockGetDetailTvSeries.execute(tId));
      },
    );
  });

  group('Save watchlist tv series,', () {
    const tTvSeriesDetailState = TvSeriesDetailState(
      upsertStatus: TvSeriesDetailUpsertSuccess('Added to watchlist'),
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with success upsert status when added is success',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Added to watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.addedToWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(
          watchlistStatus: true,
        )
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with failure upsert status when added is unsuccess',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.addedToWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState.copyWith(
            upsertStatus: const TvSeriesDetailUpsertFailure('Failure'))
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );
  });

  group('Remove watchlist tv series', () {
    const tTvSeriesDetailState = TvSeriesDetailState(
      upsertStatus: TvSeriesDetailUpsertFailure('Failure'),
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with success upsert status when added is success',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Right('Remove from watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState.copyWith(
            upsertStatus:
                const TvSeriesDetailUpsertSuccess('Remove from watchlist')),
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );

    blocTest<TvSeriesDetailCubit, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with failure upsert status when added is unsuccess',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testTvSeriesDetail),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(
          watchlistStatus: true,
        )
      ],
      verify: (_) {
        verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );
  });
}
