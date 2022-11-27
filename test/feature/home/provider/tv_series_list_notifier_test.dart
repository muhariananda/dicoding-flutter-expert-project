import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:ditonton/feature/home/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTvSeries,
  GetPopularTvSeries,
  GetTopRatedTvSeries,
])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetNowPlayingTvSeries mockGetNowPlayingTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvSeries = MockGetNowPlayingTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getNowPlayingTvSeries: mockGetNowPlayingTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3, 4],
    id: 1,
    name: 'name',
    originCountry: ["EN"],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('get now playing tv series,', () {
    test('initial state should be empty', () {
      expect(provider.nowPlayingState, RequestState.Empty);
    });

    test('should get data from the usecase', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchNowPlayingTvSeries();

      //assert
      verify(mockGetNowPlayingTvSeries.execute());
    });

    test('should state change to Loading when usecase is called', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchNowPlayingTvSeries();

      //assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change list of tv series when data is gotten successfully',
        () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      await provider.fetchNowPlayingTvSeries();

      //assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchNowPlayingTvSeries();

      //assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('get popular tv series,', () {
    test('initial state should be empty', () {
      expect(provider.popularState, RequestState.Empty);
    });

    test('should get data from the usecase', () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchPopularTvSeries();

      //assert
      verify(mockGetPopularTvSeries.execute());
    });

    test('should state change to Loading when usecase is called', () {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchPopularTvSeries();

      //assert
      expect(provider.popularState, RequestState.Loading);
    });

    test('should change list of tv series when data is gotten successuflly',
        () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      await provider.fetchPopularTvSeries();

      //assert
      expect(provider.popularState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchPopularTvSeries();

      //assert
      expect(provider.popularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('get top rated tv series,', () {
    test('initial state should be empty', () {
      expect(provider.topRatedState, RequestState.Empty);
    });

    test('should state change to Loading when the usecase is called', () {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchTopRatedTvSeries();

      //assert
      expect(provider.topRatedState, RequestState.Loading);
    });

    test('should change list of tv series whend data is gotten sucessfully',
        () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      await provider.fetchTopRatedTvSeries();

      //assert
      expect(provider.topRatedState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchTopRatedTvSeries();

      //assert
      expect(provider.topRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
