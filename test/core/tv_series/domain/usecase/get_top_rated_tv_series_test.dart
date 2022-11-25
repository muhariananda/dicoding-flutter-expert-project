import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late GetTopRatedTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTvSeries(mockRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.getTopRatedTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTvSeries));
  });
}
