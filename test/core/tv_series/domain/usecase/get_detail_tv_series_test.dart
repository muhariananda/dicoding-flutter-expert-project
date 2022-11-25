import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/tv_series/dummy_tv_series.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetDetailTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetDetailTvSeries(mockRepository);
  });

  final tId = 1;

  test('should return data tv series from the repository', () async {
    //arrange
    when(mockRepository.getTvSeriesDetail(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));

    //act
    final result = await usecase.execute(tId);

    //assert
    expect(result, Right(testTvSeriesDetail));
  });
}
