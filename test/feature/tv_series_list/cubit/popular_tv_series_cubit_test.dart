import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'popular_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesCubit cubit;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    cubit = PopularTvSeriesCubit(getPopularTvSeries: mockGetPopularTvSeries);
  });

  group('Get popular tv series,', () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, Loading());
    });

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'should emit [Success] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTvSeries(),
      expect: () => [
        HasData(testTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'should emit [Error] when data is gotten unsuccesful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('')));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTvSeries(),
      expect: () => [
        Error(''),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}
