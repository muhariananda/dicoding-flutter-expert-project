import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/tv_series/dummy_tv_series.dart';
import '../../../../helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => Right('Added to watchlist'));

    //act
    final result = await usecase.execute(testTvSeriesDetail);

    //assert
    expect(result, Right('Added to watchlist'));
  });
}
