import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_domain/movie_domain.dart';

import '../dummy_movie.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    cubit = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Get movie detail,', () {
    const tId = 1;
    const tMovieDetailState = MovieDetailState();

    test('initial state should be [MovieDetailState]', () {
      expect(cubit.state, const MovieDetailState());
    });

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [MovieDetailState] with movie data when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(tId),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(movie: testMovieDetail),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'shoudl emit [MovieDetailState] with failure message when data is gotten unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(tId),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(errorMessage: 'Not found'),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Save watchlist movie,', () {
    const tMovieDetailState = MovieDetailState(
      upsertStatus: MovieDetailUpsertSuccess('Added to watchlist'),
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [MovieDetailState] with upsertStatus is success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.addedToWatchlist(testMovieDetail),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(watchlistStatus: true),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [MovieDetailState] with upsertStatus is unsuccess',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.addedToWatchlist(testMovieDetail),
      expect: () => <MovieDetailState>[
        tMovieDetailState.copyWith(
          upsertStatus: const MovieDetailUpsertFailure('Failure'),
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove watchlist movie,', () {
    const tMovieDetailState = MovieDetailState(
      upsertStatus: MovieDetailUpsertFailure('Failure'),
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [MovieDetailState] with upsertStatus is success',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Remove from watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => <MovieDetailState>[
        tMovieDetailState.copyWith(
          upsertStatus: const MovieDetailUpsertSuccess('Remove from watchlist'),
        )
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [MovieDetailState] with upsertStatus is unsuccess',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.removeFromWatchlist(testMovieDetail),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(
          watchlistStatus: true,
        )
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}
