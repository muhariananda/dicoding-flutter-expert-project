import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../../dummy_data/dummy_tv_series.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late SearchTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockRepository);
  });

  const tQuery = 'query';

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.searchTvSeriess(tQuery))
        .thenAnswer((_) async => Right(testTvSeriesList));

    //act
    final result = await usecase.execute(tQuery);

    //assert
    expect(result, Right(testTvSeriesList));
  });
}
