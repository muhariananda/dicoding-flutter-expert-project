import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';
import 'package:ditonton/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group('Get movie detail,', () {
    final tId = 1;
    final tMovieDetailState = MovieDetailState();

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with movie data '
      'when added MovieDetailOnRequested event is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnRequested(tId)),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(
          movie: testMovieDetail,
        ),
      ],
      verify: (_) {
        mockGetMovieDetail.execute(tId);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with error message '
      'when added MovieDetailOnRequested event is gotten unsuccesful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Not found')));
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnRequested(tId)),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(
          errorMessage: 'Not found',
        ),
      ],
      verify: (_) {
        mockGetMovieDetail.execute(tId);
      },
    );
  });

  group('Save movie to watchlist,', () {
    final tMoveiDetailState = MovieDetailState(
      upsertStatus: MovieDetailUpsertSuccess('Added to Watchlist'),
      watchlistStatus: false,
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with success message '
      'when added MovieDetailOnAddedWatchlist event is gotten successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnAddedWatchlist(testMovieDetail)),
      expect: () => <MovieDetailState>[
        tMoveiDetailState,
        tMoveiDetailState.copyWith(
          watchlistStatus: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with error message '
      'when added MovieDetailOnAddedWatchlist event is gotten unsuccessful',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnAddedWatchlist(testMovieDetail)),
      expect: () => <MovieDetailState>[
        tMoveiDetailState.copyWith(
          upsertStatus: MovieDetailUpsertFailure('Failure'),
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove movie from watchlist,', () {
    final tMovieDetailState = MovieDetailState(
      upsertStatus: MovieDetailUpsertFailure('Failure'),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with success message '
      'when added MovieDetailOnRemovedWatchlist event is gotten successfully.',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnRemovedWatchlist(testMovieDetail)),
      expect: () => <MovieDetailState>[
        tMovieDetailState.copyWith(
            upsertStatus: MovieDetailUpsertSuccess('Removed from Watchlist')),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emits [MovieDetailState] with error message '
      'when added MovieDetailOnRemovedWatchlist event is gotten unsuccessful.',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return bloc;
      },
      act: (bloc) => bloc.add(MovieDetailOnRemovedWatchlist(testMovieDetail)),
      expect: () => <MovieDetailState>[
        tMovieDetailState,
        tMovieDetailState.copyWith(watchlistStatus: true),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}
