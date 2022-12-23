import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../../dummy_data/dummy_tv_series.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockRepository);
  });

  test('should get tv series list from the repository', () async {
    //arrange
    when(mockRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(testTvSeriesList));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(testTvSeriesList));
  });
}
