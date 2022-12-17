import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_data/dummy_tv_series.dart';
import '../test_helper/test_helpert.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetTvSeriesRecommendations usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendations(mockRepository);
  });

  const tId = 1;

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.getTvSeriesRecommendations(tId))
        .thenAnswer((_) async => Right(testTvSeriesList));

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, Right(testTvSeriesList));
  });
}
