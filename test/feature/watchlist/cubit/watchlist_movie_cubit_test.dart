import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'watchlist_movie_cubit_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistMovieCubit cubit;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    cubit = WatchlistMovieCubit(
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group('Get watchlist movie,', () {
    test('intial should be [WatchlistMovieInProgress]', () {
      expect(cubit.state, WatchlistMovieInProgress());
    });

    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [WatchlistMovieSuccess] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistMovies(),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieSuccess(movies: testMovieList),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieCubit, WatchlistMovieState>(
      'should emit [WatchlistMovieFailure] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistMovies(),
      expect: () => <WatchlistMovieState>[
        WatchlistMovieFailure(message: 'Failure'),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
