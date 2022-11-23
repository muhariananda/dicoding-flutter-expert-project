import 'package:dartz/dartz.dart';
import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/movie/domain/usecase/search_movies.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:ditonton/features/search/search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie/dummy_movie.dart';
import '../../dummy_data/tv_series/dummy_tv_series.dart';
import 'search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvSeries])
void main() {
  late SearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvSeries mockSearchTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTvSeries = MockSearchTvSeries();
    provider = SearchNotifier(
      searchMovies: mockSearchMovies,
      searchTvSeries: mockSearchTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tQuery = 'query';

  group('search movie,', () {
    test('initial state should be empty', () {
      expect(provider.movieState, RequestState.Empty);
    });

    test('should get data when the usecase is called', () {
      //arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));

      //act
      provider.fetchMovieSearch(tQuery);

      //assert
      verify(mockSearchMovies.execute(tQuery));
    });

    test('should return movies data when the data is gotten successfully',
        () async {
      //arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(testMovieList));

      //act
      await provider.fetchMovieSearch(tQuery);

      //assert
      verify(mockSearchMovies.execute(tQuery));
      expect(provider.movieState, RequestState.Loaded);
      expect(provider.movieSearchResult, testMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when the data is gotten unsuccessful', () async {
      //arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchMovieSearch(tQuery);

      //assert
      verify(mockSearchMovies.execute(tQuery));
      expect(provider.movieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv series,', () {
    test('intial state should be Empty', () {
      expect(provider.tvSeriesState, RequestState.Empty);
    });

    test('should get data when the usecase is called', () {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      provider.fetchTvSeriesSearch(tQuery);

      //assert
      verify(mockSearchTvSeries.execute(tQuery));
    });

    test('should return list of tv series when the data is gotten successflly',
        () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchTvSeriesSearch(tQuery);

      //assert
      verify(mockSearchTvSeries.execute(tQuery));
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesSearchResult, testTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when the data is gotten unsuccessful', () async {
      //arrange
      when(mockSearchTvSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      //act
      await provider.fetchTvSeriesSearch(tQuery);

      //assert
      verify(mockSearchTvSeries.execute(tQuery));
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  test('selected content should change', () {
    provider.setSelectedContent(ContentSelection.tv);
    expect(provider.selectedContent, ContentSelection.tv);
  });
}
