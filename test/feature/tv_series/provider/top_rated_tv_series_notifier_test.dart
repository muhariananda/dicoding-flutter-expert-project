import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:ditonton/feature/tv_series/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvSeries])
void main() {
  late TopRatedTvSeriesNotifier provider;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider =
        TopRatedTvSeriesNotifier(getTopRatedTvSeries: mockGetTopRatedTvSeries)
          ..addListener(() {
            listenerCallCount += 1;
          });
  });

  group('get top rated tv series', () {
    test('initial state should be empty', () {
      expect(provider.topRatedTvSeriesState, RequestState.Empty);
    });

    test('should change state to Loading when data is called', () {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      provider.fetchTopRatedTvSeries();

      //assert
      verify(mockGetTopRatedTvSeries.execute());
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test(
        'should return list of tv series data when data is gotten successfully',
        () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchTopRatedTvSeries();

      //assert
      verify(mockGetTopRatedTvSeries.execute());
      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchTopRatedTvSeries();

      //assert
      verify(mockGetTopRatedTvSeries.execute());
      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
