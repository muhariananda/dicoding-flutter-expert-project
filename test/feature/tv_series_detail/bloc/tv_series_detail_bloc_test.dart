import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:ditonton/feature/tv_series_detail/bloc/tv_series_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
  GetWatchlistStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailBloc bloc;
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;

  setUp(() {
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    bloc = TvSeriesDetailBloc(
      getDetailTvSeries: mockGetDetailTvSeries,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    );
  });

  group('Get detail tv series,', () {
    final tId = 1;
    final tTvSeriesDetailState = TvSeriesDetailState();

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits [TvSeriesDetailState] with tv series data when TvSeriesDetailOnRequested is added.',
      build: () {
        when(mockGetDetailTvSeries.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(TvSeriesDetailOnRequested(tId)),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(
          tvSeries: testTvSeriesDetail,
        ),
      ],
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits [TvSeriesDetailState] with error message when TvSeriesDetailOnRequested is added.',
      build: () {
        when(mockGetDetailTvSeries.execute(tId)).thenAnswer(
          (_) async => Left(ServerFailure('Not found')),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(TvSeriesDetailOnRequested(tId)),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(
          errorMessage: 'Not found',
        ),
      ],
    );
  });

  group('Save watchlist tv series', () {
    final tTvDetailState = TvSeriesDetailState(
      upsertStatus: TvSeriesDetailUpsertSuccess('Added to Watchlist'),
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with success watchlist message when added TvSeriesDetailOnAddedWatchlist event',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(TvSeriesDetailOnAddedWatchlist(testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        tTvDetailState,
        tTvDetailState.copyWith(
          watchlistStatus: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emit [TvSeriesDetailState] with failure watchlist message when added TvSeriesDetailOnAddedWatchlist event',
      build: () {
        when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(TvSeriesDetailOnAddedWatchlist(testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        tTvDetailState.copyWith(
          upsertStatus: TvSeriesDetailUpsertFailure('Failure'),
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
        verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      },
    );
  });

  group('Remove watchlist tv series,', () {
    final tTvSeriesDetailState = TvSeriesDetailState(
      upsertStatus: TvSeriesDetailUpsertFailure('Failure'),
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits [TvSeriesDetailState] with success message when added TvSeriesOnRemovedWatchlist event',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(TvSeriesDetailOnRemovedWatchlist(testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState.copyWith(
            upsertStatus:
                TvSeriesDetailUpsertSuccess('Removed from Watchlist')),
      ],
      verify: (_) {
        mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail);
        mockGetWatchlistStatus.execute(testTvSeriesDetail.id);
      },
    );

    blocTest<TvSeriesDetailBloc, TvSeriesDetailState>(
      'should emits [TvSeriesDetailState] with failure message when added TvSeriesOnRemovedWatchlist event',
      build: () {
        when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) =>
          bloc.add(TvSeriesDetailOnRemovedWatchlist(testTvSeriesDetail)),
      expect: () => <TvSeriesDetailState>[
        tTvSeriesDetailState,
        tTvSeriesDetailState.copyWith(watchlistStatus: true),
      ],
      verify: (_) {
        mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail);
        mockGetWatchlistStatus.execute(testTvSeriesDetail.id);
      },
    );
  });
}
