import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_domain/tv_series_domain.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
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
      expect(cubit.state, const TopRatedTvSeriesInProgress());
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
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedTvSeries(),
      expect: () => [
        const TopRatedTvSeriesFailure(''),
      ],
      verify: (_) {
        verify(mockGetTopRatedTvSeries.execute());
      },
    );
  });
}
