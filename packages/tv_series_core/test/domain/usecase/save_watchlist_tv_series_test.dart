import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../../dummy_data/dummy_tv_series.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late SaveWatchlistTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = SaveWatchlistTvSeries(mockRepository);
  });

  test('should save tv series to the repository', () async {
    //arrange
    when(mockRepository.saveWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Added to watchlist'));

    //act
    final result = await usecase.execute(testTvSeriesDetail);

    //assert
    expect(result, const Right('Added to watchlist'));
  });
}
