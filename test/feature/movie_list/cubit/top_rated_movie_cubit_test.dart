import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'top_rated_movie_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late TopRatedMovieCubit cubit;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    cubit = TopRatedMovieCubit(getTopRatedMovies: mockGetTopRatedMovies);
  });

  group('Get top rated movies,', () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, TopRatedMovieInProgress());
    });

    blocTest<TopRatedMovieCubit, TopRatedMovieState>(
      'should emit [Success] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovie(),
      expect: () => [
        TopRatedMovieSuccess(testMovieList),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieCubit, TopRatedMovieState>(
      'should emit [Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovie(),
      expect: () => [
        TopRatedMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
