import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:ditonton/features/popular_tv_series/popular_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'popular_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late PopularTvSeriesNotifier provider;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    provider =
        PopularTvSeriesNotifier(getPopularTvSeries: mockGetPopularTvSeries)
          ..addListener(() {
            listenerCallCount += 1;
          });
  });

  group('get popular tv series,', () {
    test('initial state should be empty', () {
      expect(provider.popularTvSeriesState, RequestState.Empty);
    });

    test('should change state to Loading when the usecase is called', () {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      provider.fetchPopularTvSeries();

      //assert
      verify(mockGetPopularTvSeries.execute());
      expect(provider.popularTvSeriesState, RequestState.Loading);
    });

    test(
        'should return list of tv series data when data is gotten successfully',
        () async {
      //assert
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchPopularTvSeries();

      //assert
      verify(mockGetPopularTvSeries.execute());
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Not Found')));

      //act
      await provider.fetchPopularTvSeries();

      //assert
      verify(mockGetPopularTvSeries.execute());
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Not Found');
      expect(listenerCallCount, 2);
    });
  });
}
