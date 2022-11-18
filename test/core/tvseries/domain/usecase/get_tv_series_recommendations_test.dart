import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetTvSeriesRecommendations usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockRepository);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(tTvSeries));

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, Right(tTvSeries));
  });
}
