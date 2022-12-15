import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_domain/movie_domain.dart';
import 'package:movie_list/movie_list.dart';

import '../dummy_movie.dart';
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
      expect(cubit.state, const TopRatedMovieInProgress());
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
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovie(),
      expect: () => [
        const TopRatedMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
