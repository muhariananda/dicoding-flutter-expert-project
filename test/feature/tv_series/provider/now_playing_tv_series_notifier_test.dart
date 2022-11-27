import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:ditonton/feature/tv_series/provider/now_playing_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'now_playing_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvSeries])
void main() {
  late NowPlayingTvSeriesNotifier provider;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    provider = NowPlayingTvSeriesNotifier(
        getNowPlayingTvSeries: mockGetNowPlayingTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('get now playing tv series,', () {
    test('initial state should be empty', () {
      expect(provider.state, RequestState.Empty);
    });

    test('should change state to Loading when the usecase is called', () {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      provider.fetchNowPlayingTvSeries();

      //assert
      verify(mockGetNowPlayingTvSeries.execute());
      expect(provider.state, RequestState.Loading);
    });

    test(
        'should return list of tv series data when data is gotten successfully',
        () async {
      //assert
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchNowPlayingTvSeries();

      //assert
      verify(mockGetNowPlayingTvSeries.execute());
      expect(provider.state, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Not Found')));

      //act
      await provider.fetchNowPlayingTvSeries();

      //assert
      verify(mockGetNowPlayingTvSeries.execute());
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Not Found');
      expect(listenerCallCount, 2);
    });
  });
}
