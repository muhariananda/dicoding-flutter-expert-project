import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'movie_detail_cubit_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
])
void main() {
  late MovieDetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    cubit = MovieDetailCubit(
      getMovieDetail: mockGetMovieDetail,
    );
  });

  group('Get movie detail,', () {
    final tId = 1;

    test('initial state should be [Loading]', () {
      expect(cubit.state, MovieDetailInProgress());
    });

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [HasData] when data is gotten is successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(tId),
      expect: () => <MovieDetailState>[
        MovieDetailSuccess(movie: testMovieDetail),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailCubit, MovieDetailState>(
      'should emit [Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(tId),
      expect: () => <MovieDetailState>[
        MovieDetailFailure(message: ''),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });
}
