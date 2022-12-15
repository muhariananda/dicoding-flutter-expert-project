import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_domain/movie_domain.dart';
import 'package:movie_list/movie_list.dart';

import '../dummy_movie.dart';
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
      expect(cubit.state, const PopularMovieInProgress());
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
          (_) async => const Left(ServerFailure('Server Failure')),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const PopularMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
