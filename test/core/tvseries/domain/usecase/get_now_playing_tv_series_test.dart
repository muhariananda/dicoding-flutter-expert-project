import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvSeries usecase;
  late MockTvSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = GetNowPlayingTvSeries(mockRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get tv series list from the repository', () async {
    //arrange
    when(mockRepository.getNowPlayingTvSeries())
        .thenAnswer((_) async => Right(tTvSeries));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTvSeries));
  });
}
