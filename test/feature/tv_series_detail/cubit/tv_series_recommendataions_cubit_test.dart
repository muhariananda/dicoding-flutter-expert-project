import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_recommendations_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_recommendataions_cubit_test.mocks.dart';

@GenerateMocks([GetTvSeriesRecommendations])
void main() {
  late TvSeriesRecommendationsCubit cubit;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;

  setUp(() {
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    cubit = TvSeriesRecommendationsCubit(
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
    );
  });

  group('Get recommendations tv series,', () {
    final tId = 1;

    test('initial state should be [TvSeriesRecommendationsInProgress]', () {
      expect(cubit.state, TvSeriesRecommendationsInProgress());
    });

    blocTest<TvSeriesRecommendationsCubit, TvSeriesRecommendationsState>(
      'should emit [TvSeriesRecommendationsSuccess] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvSeriesList));
        return cubit;
      },
      act: (cubit) => cubit.fetchRecommendationsTvSeries(tId),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );

    blocTest<TvSeriesRecommendationsCubit, TvSeriesRecommendationsState>(
      'should emit [TvSeriesRecommendationsFailure] when data is gotten unsuccessful',
      build: () {
        when(mockGetTvSeriesRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchRecommendationsTvSeries(tId),
      expect: () => <TvSeriesRecommendationsState>[
        TvSeriesRecommendationsFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });
}
