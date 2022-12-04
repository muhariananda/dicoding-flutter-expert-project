import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_recommendations.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_recommendations_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
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
    final tId = 1;

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
          .thenAnswer((_) async => Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieRecommendations(tId),
      expect: () => <MovieRecommendationsState>[
        MovieRecommendationsFailure(
          message: 'Not found'
        ),
      ],
      verify: (_) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });
}
