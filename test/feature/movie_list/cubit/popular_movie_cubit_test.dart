import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_popular_movies.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'popular_movie_cubit_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late PopularMovieCubit cubit;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    cubit = PopularMovieCubit(getPopularMovies: mockGetPopularMovies);
  });

  group('Get popular movies,', () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, PopularMovieInProgress());
    });

    blocTest<PopularMovieCubit, PopularMovieState>(
      'should emit [Success] when data is gotten successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        PopularMovieSuccess(testMovieList),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieCubit, PopularMovieState>(
      'should emit [Error] when data is gotten unsuccessfull',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
          (_) async => Left(ServerFailure('Server Failure')),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        PopularMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
