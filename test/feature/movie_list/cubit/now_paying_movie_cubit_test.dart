import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton/feature/movie_list/cubit/now_playing_movie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'now_paying_movie_cubit_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late NowPlayingMovieCubit cubit;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    cubit = NowPlayingMovieCubit(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  group("Get now playing movies,", () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, NowPlayingMovieInProgress());
    });

    blocTest<NowPlayingMovieCubit, NowPlayingMovieState>(
      'should emit [Success] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingMovie(),
      expect: () => [
        NowPlayingMovieSuccess(testMovieList),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMovieCubit, NowPlayingMovieState>(
      'should emit [Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingMovie(),
      expect: () => [
        NowPlayingMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
