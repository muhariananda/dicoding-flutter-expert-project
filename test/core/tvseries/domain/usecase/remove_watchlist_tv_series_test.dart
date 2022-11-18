import 'package:dartz/dartz.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => Right('Removed from the watchlist'));

    //act
    final result = await usecase.exceute(testTvSeriesDetail);

    //assert
    expect(result, Right('Removed from the watchlist'));
  });
}
