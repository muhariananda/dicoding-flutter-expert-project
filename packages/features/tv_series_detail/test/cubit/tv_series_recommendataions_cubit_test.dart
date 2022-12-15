import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_tv_series.dart';
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
    const tId = 1;

    test('initial state should be [TvSeriesRecommendationsInProgress]', () {
      expect(cubit.state, const TvSeriesRecommendationsInProgress());
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
            .thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchRecommendationsTvSeries(tId),
      expect: () => <TvSeriesRecommendationsState>[
        const TvSeriesRecommendationsFailure(message: 'Not found'),
      ],
      verify: (_) {
        verify(mockGetTvSeriesRecommendations.execute(tId));
      },
    );
  });
}
