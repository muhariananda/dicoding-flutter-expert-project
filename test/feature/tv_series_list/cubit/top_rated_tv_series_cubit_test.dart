import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'top_rated_tv_series_cubit_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesCubit cubit;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;

  setUp(() {
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    cubit = TopRatedTvSeriesCubit(getTopRatedTvSeries: mockGetTopRatedTvSeries);
  });

  group('Get top rated tv series,', () {
    test('initial state should be [Loading]', () {
      expect(cubit.state, TopRatedTvSeriesInProgress());
    });

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      'should emit [HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Right(testTvSeriesList));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      expect: () => [
        TopRatedTvSeriesSuccess(testTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );

    blocTest<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
      'should emit [Error] when data is gotten unsuccessful',
      build: () {
        when(mockGetTopRatedTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      expect: () => [
        TopRatedTvSeriesFailure(''),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
