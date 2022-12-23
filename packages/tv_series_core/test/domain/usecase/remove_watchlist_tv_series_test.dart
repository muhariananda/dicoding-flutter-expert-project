import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../../dummy_data/dummy_tv_series.dart';
import '../../test_helper/test_helper.mocks.dart';

void main() {
  late MockTvSeriesRepository mockRepository;
  late RemoveWatchlistTvSeries usecase;

  setUp(() {
    mockRepository = MockTvSeriesRepository();
    usecase = RemoveWatchlistTvSeries(mockRepository);
  });

  test('should remove the tv series from the repository', () async {
    //arrange
    when(mockRepository.removeWatchlist(testTvSeriesDetail))
        .thenAnswer((_) async => const Right('Removed from the watchlist'));

    //act
    final result = await usecase.execute(testTvSeriesDetail);

    //assert
    expect(result, const Right('Removed from the watchlist'));
  });
}
