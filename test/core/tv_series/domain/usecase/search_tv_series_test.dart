import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late SearchTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SearchTvSeries(mockRepository);
  });

  final tQuery = 'query';
  final tTvSeries = <TvSeries>[];

  test('should return list of Tv Series from the repository', () async {
    //arrange
    when(mockRepository.searchTvSeriess(tQuery))
        .thenAnswer((_) async => Right(tTvSeries));

    //act
    final result = await usecase.execute(tQuery);

    //assert
    expect(result, Right(tTvSeries));
  });
}
