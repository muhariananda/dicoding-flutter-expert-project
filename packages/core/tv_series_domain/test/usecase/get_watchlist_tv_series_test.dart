import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_data/dummy_tv_series.dart';
import '../test_helper/test_helpert.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetWatchListTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetWatchListTvSeries(mockRepository);
  });

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.getWatchlistTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(testTvSeriesList));
  });
}
