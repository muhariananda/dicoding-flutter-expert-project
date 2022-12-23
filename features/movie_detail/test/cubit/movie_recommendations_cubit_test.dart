import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_core/movie_core.dart';

import '../dummy_movie.dart';
import 'movie_recommendations_cubit_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsCubit cubit;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    cubit = MovieRecommendationsCubit(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  group('Get movie recommendations,', () {
    const tId = 1;

    test('initial state should be [MovieRecommendationsInProgress]', () {
      expect(cubit.state, MovieRecommendationsInProgress());
    });

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should emit [MovieRecommendationsSuccess] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieRecommendations(tId),
      expect: () => <MovieRecommendationsState>[
        MovieRecommendationsSuccess(movies: testMovieList),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieRecommendationsCubit, MovieRecommendationsState>(
      'should emit [MovieRecommendationsFailure] when data is gotten unsuccesful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieRecommendations(tId),
      expect: () => <MovieRecommendationsState>[
        const MovieRecommendationsFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
}
