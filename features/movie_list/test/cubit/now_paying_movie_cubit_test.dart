import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_core/movie_core.dart';
import 'package:movie_list/movie_list.dart';

import '../dummy_movie.dart';
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
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return cubit;
      },
      act: (cubit) => cubit.fetchNowPlayingMovie(),
      expect: () => [
        const NowPlayingMovieFailure('Server Failure'),
      ],
      verify: (_) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
