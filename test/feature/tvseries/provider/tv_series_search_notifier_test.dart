import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:ditonton/features/search/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late MockSearchTvSeries mockSearchTvSeries;
  late TvSeriesSearchNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvSeries = MockSearchTvSeries();
    provider = TvSeriesSearchNotifier(searchTvSeries: mockSearchTvSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tQuery = 'Chainsaw Man';
  final tTvSeries = TvSeries(
    backdropPath: '/5DUMPBSnHOZsbBv81GFXZXvDpo6.jpg',
    firstAirDate: '2022-10-12',
    genreIds: [16, 10759, 10765, 35],
    id: 114410,
    name: 'Chainsaw Man',
    originCountry: ["JP"],
    originalLanguage: 'ja',
    originalName: 'チェンソーマン',
    overview:
        'Denji has a simple dream—to live a happy and peaceful life, spending time with a girl he likes.',
    popularity: 1884.124,
    posterPath: '/yVtx7Xn9UxNJqvG2BkvhCcmed9S.jpg',
    voteAverage: 8.6,
    voteCount: 265,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('search tv series,', () {
    test('intial state should be empty', () {
      expect(provider.searchState, RequestState.Empty);
    });

    test('should change state to Loading when the usecase is called', () {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      provider.fetchTvSeriesSearch(tQuery);

      //assert
      expect(provider.searchState, RequestState.Loading);
    });

    test('should return list of tv series when data is successfully', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));

      //act
      await provider.fetchTvSeriesSearch(tQuery);

      //assert
      expect(provider.searchState, RequestState.Loaded);
      expect(provider.searchResults, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchTvSeriesSearch(tQuery);

      //assert
      expect(provider.searchState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
