import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/core/movie/data/models/genre_model.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_local_data_source.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_remote_data_source.dart';
import 'package:ditonton/core/tv_series/data/models/season_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late TvSeriesRemoteDataSource mockRemoteDataSource;
  late TvSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvSeriesLocalDataSource();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvSeriesModel = TvSeriesModel(
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

  final tTvSeriesModelList = <TvSeriesModel>[tTvSeriesModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('get now playing tv series,', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        //arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);

        //act
        final result = await repository.getNowPlayingTvSeries();

        //assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return server failure when the call to remote data souce is unsuccesful',
      () async {
        //arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries())
            .thenThrow(ServerException());

        //act
        final result = await repository.getNowPlayingTvSeries();

        //assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());
        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return connection failure when the device not connected to intertnet',
      () async {
        //arrange
        when(mockRemoteDataSource.getNowPlayingTvSeries())
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getNowPlayingTvSeries();

        //assert
        verify(mockRemoteDataSource.getNowPlayingTvSeries());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get top rated tv series,', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      //arrange
      when(mockRemoteDataSource.getTopRatedTvSeries())
          .thenAnswer((_) async => tTvSeriesModelList);

      //act
      final result = await repository.getTopRatedTvSeries();

      //assert
      verify(mockRemoteDataSource.getTopRatedTvSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        //arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenThrow(ServerException());

        //act
        final result = await repository.getTopRatedTvSeries();

        //assert
        verify(mockRemoteDataSource.getTopRatedTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        //arrange
        when(mockRemoteDataSource.getTopRatedTvSeries())
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getTopRatedTvSeries();

        //assert
        verify(mockRemoteDataSource.getTopRatedTvSeries());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get popular tv series,', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        //arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenAnswer((_) async => tTvSeriesModelList);

        //act
        final result = await repository.getPopularTvSeries();

        //assert
        verify(mockRemoteDataSource.getPopularTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        //arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenThrow(ServerException());

        //act
        final result = await repository.getPopularTvSeries();

        //assert
        verify(mockRemoteDataSource.getPopularTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        //arrange
        when(mockRemoteDataSource.getPopularTvSeries())
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getPopularTvSeries();

        //assert
        verify(mockRemoteDataSource.getPopularTvSeries());
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get detail tv series,', () {
    final tId = 1;
    final tTvSeriesDetailResponse = TvSeriesDetailResponse(
      backdropPath: 'path.jpg',
      firstAirDate: 'firstAirDate',
      genres: [GenreModel(id: 1, name: 'name')],
      seasons: [
        SeasonModel(
          airDate: 'airDate',
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1,
        )
      ],
      id: 1,
      name: 'name',
      originCountry: ['en'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1.0,
      posterPath: 'posterPath',
      voteAverage: 1.0,
      voteCount: 1,
    );

    test(
      'should return TvSeries data when the call to remote data source is successful',
      () async {
        //arrange
        when(mockRemoteDataSource.getTvSeriesDetail(tId))
            .thenAnswer((_) async => tTvSeriesDetailResponse);

        //act
        final result = await repository.getTvSeriesDetail(tId);

        //assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, equals(Right(testTvSeriesDetail)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        //arrange
        when(mockRemoteDataSource.getTvSeriesDetail(tId))
            .thenThrow(ServerException());

        //act
        final result = await repository.getTvSeriesDetail(tId);

        //assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the device is not connected to internet',
      () async {
        //arrange
        when(mockRemoteDataSource.getTvSeriesDetail(tId))
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getTvSeriesDetail(tId);

        //assert
        verify(mockRemoteDataSource.getTvSeriesDetail(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );
  });

  group('get recommendation tv series,', () {
    final tId = 1;
    test(
      'should return data tv series list when the call data source is successful',
      () async {
        //arrange
        when(mockRemoteDataSource.getRecommendationsTvSeries(tId))
            .thenAnswer((_) async => tTvSeriesModelList);

        //act
        final result = await repository.getTvSeriesRecommendations(tId);

        //assert
        verify(mockRemoteDataSource.getRecommendationsTvSeries(tId));
        final resultList = result.getOrElse(() => []);
        expect(resultList, equals(tTvSeriesList));
      },
    );

    test(
      'should return server failure when the call to remote data source is successfull',
      () async {
        //arrange
        when(mockRemoteDataSource.getRecommendationsTvSeries(tId))
            .thenThrow(ServerException());

        //act
        final result = await repository.getTvSeriesRecommendations(tId);

        //assert
        verify(mockRemoteDataSource.getRecommendationsTvSeries(tId));
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return connection failure when the call to remote data source is unsuccessful',
      () async {
        //arrange
        when(mockRemoteDataSource.getRecommendationsTvSeries(tId))
            .thenThrow(SocketException('Failed to connect to the network'));

        //act
        final result = await repository.getTvSeriesRecommendations(tId);

        //assert
        verify(mockRemoteDataSource.getRecommendationsTvSeries(tId));
        expect(
          result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))),
        );
      },
    );

    group(
      'search tv series,',
      () {
        final tQuery = 'Chainsaw Man';

        test(
          'should return tv series list data when the call to remote data source is successful',
          () async {
            //arrange
            when(mockRemoteDataSource.searchTvSeries(tQuery))
                .thenAnswer((_) async => tTvSeriesModelList);

            //act
            final result = await repository.searchTvSeriess(tQuery);

            //assert
            verify(mockRemoteDataSource.searchTvSeries(tQuery));

            final resultList = result.getOrElse(() => []);
            expect(resultList, equals(tTvSeriesList));
          },
        );
      },
    );
  });

  group('save watchlist tv series,', () {
    test('should return success message when saving is successful', () async {
      //arrange
      when(mockLocalDataSource.insertTvSeriesWatchlist(testTvSeriesTable))
          .thenAnswer((_) async => 'Added to watchlist');

      //act
      final result = await repository.saveWatchlist(testTvSeriesDetail);

      //assert
      verify(mockLocalDataSource.insertTvSeriesWatchlist(testTvSeriesTable));
      expect(result, Right('Added to watchlist'));
    });

    test(
      'should return database failure when saving is unsuccessfull',
      () async {
        //arrange
        when(mockLocalDataSource.insertTvSeriesWatchlist(testTvSeriesTable))
            .thenThrow(DatabaseException('Failed to add watchlist'));

        //act
        final result = await repository.saveWatchlist(testTvSeriesDetail);

        //assert
        verify(mockLocalDataSource.insertTvSeriesWatchlist(testTvSeriesTable));
        expect(result, Left(DatabaseFailure('Failed to add watchlist')));
      },
    );
  });

  group('remove watchlist tv series,', () {
    test(
      'should return success message when removing is successful',
      () async {
        //arrange
        when(mockLocalDataSource.removeTvSeriesWatchlist(testTvSeriesTable))
            .thenAnswer((_) async => 'Removed from watchlist');

        //act
        final result = await repository.removeWatchlist(testTvSeriesDetail);

        //assert
        verify(mockLocalDataSource.removeTvSeriesWatchlist(testTvSeriesTable));
        expect(result, Right('Removed from watchlist'));
      },
    );

    test(
      'should return database failure when removing is unsuccessful',
      () async {
        //arrange
        when(mockLocalDataSource.removeTvSeriesWatchlist(testTvSeriesTable))
            .thenThrow(DatabaseException('Failed to remove watchlist'));

        //act
        final result = await repository.removeWatchlist(testTvSeriesDetail);

        //assert
        verify(mockLocalDataSource.removeTvSeriesWatchlist(testTvSeriesTable));
        expect(
          result,
          Left(DatabaseFailure('Failed to remove watchlist')),
        );
      },
    );
  });

  group('get status watchlist tv series,', () {
    final tId = 1;
    test('should return watch status wheter data is found', () async {
      //arrange
      when(mockLocalDataSource.getTvSeriesById(tId))
          .thenAnswer((_) async => null);

      //act
      final result = await repository.isAddedToWatchlist(tId);

      //arrange
      expect(result, false);
    });
  });

  group('get watchlist tv series,', () {
    test('should return list of Tv Series', () async {
      //arrange
      when(mockLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvSeriesTable]);

      //act
      final result = await repository.getWatchlistTvSeries();

      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTvSeriesWatchlist]);
    });
  });
}
