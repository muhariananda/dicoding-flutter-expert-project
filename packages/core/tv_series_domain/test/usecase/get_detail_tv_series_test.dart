import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

import '../dummy_data/dummy_tv_series.dart';
import '../test_helper/test_helpert.mocks.dart';

void main() {
  late GetDetailTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetDetailTvSeries(mockRepository);
  });

  const tId = 1;

  test('should return data tv series from the repository', () async {
    //arrange
    when(mockRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => const Right(testTvSeriesDetail));

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, const Right(testTvSeriesDetail));
  });
}
