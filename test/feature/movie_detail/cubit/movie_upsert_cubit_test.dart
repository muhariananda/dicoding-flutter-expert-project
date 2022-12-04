import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_upsert_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import '../../movie/provider/movie_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetWatchlistStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieUpsertCubit cubit;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockSaveWatchlist = MockSaveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    cubit = MovieUpsertCubit(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Add watchlist movie,', () {
    blocTest<MovieUpsertCubit, MovieUpsertState>(
      'should update status and return success message when save is sucess',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => <MovieUpsertState>[
        MovieUpsertState(
          isAddetoWatchlist: false,
          watchlistMessage: 'Added to Watchlist',
        ),
        MovieUpsertState(
          isAddetoWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieUpsertCubit, MovieUpsertState>(
      'should return failure message when save is unsuccess',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.addWatchlist(testMovieDetail),
      expect: () => <MovieUpsertState>[
        MovieUpsertState(
          isAddetoWatchlist: false,
          watchlistMessage: 'Failure',
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove watchlist movie,', () {
    blocTest<MovieUpsertCubit, MovieUpsertState>(
      'should update status and return success message when remove is success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => <MovieUpsertState>[
        MovieUpsertState(
          isAddetoWatchlist: false,
          watchlistMessage: 'Removed from Watchlist',
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieUpsertCubit, MovieUpsertState>(
      'should return failure message when remove is success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => <MovieUpsertState>[
        MovieUpsertState(
          isAddetoWatchlist: false,
          watchlistMessage: 'Failure',
        ),
        MovieUpsertState(
          isAddetoWatchlist: true,
          watchlistMessage: 'Failure',
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}
