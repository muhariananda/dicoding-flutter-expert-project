import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
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
      expect(cubit.state, PopularTvSeriesInProgress());
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
        PopularTvSeriesSuccess(testTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );

    blocTest<PopularTvSeriesCubit, PopularTvSeriesState>(
      'should emit [Error] when data is gotten unsuccesful',
      build: () {
        when(mockGetPopularTvSeries.execute())
            .thenAnswer((_) async => const Left(ServerFailure('')));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularTvSeries(),
      expect: () => [
        const PopularTvSeriesFailure(''),
      ],
      verify: (_) {
        verify(mockGetPopularTvSeries.execute());
      },
    );
  });
}
