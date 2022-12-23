import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_core/movie_core.dart';
import 'package:watchlist/watchlist.dart';

import '../dummy_data/dummy_movie.dart';
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
            .thenAnswer((_) async => const Left(DatabaseFailure('Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchWatchlistMovies(),
      expect: () => <WatchlistMovieState>[
        const WatchlistMovieFailure(message: 'Failure'),
      ],
      verify: (_) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
