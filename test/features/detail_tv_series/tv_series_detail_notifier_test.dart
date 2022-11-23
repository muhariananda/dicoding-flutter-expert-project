import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:ditonton/features/detail_tv_series/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetDetailTvSeries,
  GetTvSeriesRecommendations,
  GetWatchlistStatus,
  SaveWatchlistTvSeries,
  RemoveWatchlistTvSeries,
])
void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetDetailTvSeries mockGetDetailTvSeries;
  late MockGetTvSeriesRecommendations mockGetTvSeriesRecommendations;
  late MockGetWatchlistStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvSeries mockSaveWatchlistTvSeries;
  late MockRemoveWatchlistTvSeries mockRemoveWatchlistTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetDetailTvSeries = MockGetDetailTvSeries();
    mockGetTvSeriesRecommendations = MockGetTvSeriesRecommendations();
    mockGetWatchlistStatus = MockGetWatchlistStatus();
    mockSaveWatchlistTvSeries = MockSaveWatchlistTvSeries();
    mockRemoveWatchlistTvSeries = MockRemoveWatchlistTvSeries();
    provider = TvSeriesDetailNotifier(
      getDetailTvSeries: mockGetDetailTvSeries,
      getTvSeriesRecommendations: mockGetTvSeriesRecommendations,
      getWatchlistStatus: mockGetWatchlistStatus,
      saveWatchlistTvSeries: mockSaveWatchlistTvSeries,
      removeWatchlistTvSeries: mockRemoveWatchlistTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  void _arrangeUsecase() {
    when(mockGetDetailTvSeries.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesDetail));
    when(mockGetTvSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(testTvSeriesList));
  }

  group('get detail tv series,', () {
    test('should get data from the usecase', () async {
      //arrange
      _arrangeUsecase();

      //act
      await provider.fetchTvSeriesDetail(tId);

      //aserrt
      verify(mockGetDetailTvSeries.execute(tId));
      verify(mockGetTvSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () async {
      //arrange
      _arrangeUsecase();

      //act
      provider.fetchTvSeriesDetail(tId);

      //assert
      expect(provider.tvSeriesState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      //arrange
      _arrangeUsecase();

      //act
      await provider.fetchTvSeriesDetail(tId);

      //assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTvSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesList));

      //act
      await provider.fetchTvSeriesDetail(tId);

      //assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Failed');
      expect(listenerCallCount, 2);
    });
  });

  group('get tv series recommendations,', () {
    test('should get data from the usecase', () async {
      //arrange
      _arrangeUsecase();

      //act
      await provider.fetchTvSeriesDetail(tId);

      //assert
      verify(mockGetTvSeriesRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, testTvSeriesList);
    });

    test('should change recommendations when data is gotten successfully',
        () async {
      //arrange
      _arrangeUsecase();

      //act
      await provider.fetchTvSeriesDetail(tId);

      //assert
      expect(provider.recommendationsState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, testTvSeriesList);
      expect(listenerCallCount, 3);
    });

    test('should return error when data is gotten unsuccessful', () async {
      //arrange
      when(mockGetDetailTvSeries.execute(tId))
          .thenAnswer((_) async => Right(testTvSeriesDetail));
      when(mockGetTvSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));

      //act
      await provider.fetchTvSeriesDetail(tId);

      //assert
      expect(provider.recommendationsState, RequestState.Error);
      expect(provider.message, 'Failed');
      expect(listenerCallCount, 3);
    });
  });

  group('watchlist', () {
    test('should get watchlist status', () async {
      //assert
      when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);

      //act
      await provider.loadWatchlistStatus(tId);

      //assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function is called', () async {
      //assert
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      //act
      await provider.addTvSeriesToWatchlist(testTvSeriesDetail);

      //assert
      verify(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should execute remove watchlist when function is called', () async {
      //assert
      when(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Removed from watchlist'));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      //act
      await provider.removeFromWatchlist(testTvSeriesDetail);

      //assert
      verify(mockRemoveWatchlistTvSeries.execute(testTvSeriesDetail));
    });

    test('should change the status when update the watchlist is successfull',
        () async {
      //assert
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Right('Added to watchlist'));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => true);

      //act
      await provider.addTvSeriesToWatchlist(testTvSeriesDetail);

      //assert
      verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      expect(provider.watchlistMessage, 'Added to watchlist');
      expect(provider.isAddedToWatchlist, true);
      expect(listenerCallCount, 1);
    });

    test('should change the message when update the watchlist is unsuccessful',
        () async {
      //arrange
      when(mockSaveWatchlistTvSeries.execute(testTvSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvSeriesDetail.id))
          .thenAnswer((_) async => false);

      //act
      await provider.addTvSeriesToWatchlist(testTvSeriesDetail);

      //assert
      verify(mockGetWatchlistStatus.execute(testTvSeriesDetail.id));
      expect(provider.watchlistMessage, 'Failed');
      expect(provider.isAddedToWatchlist, false);
      expect(listenerCallCount, 1);
    });
  });
}
