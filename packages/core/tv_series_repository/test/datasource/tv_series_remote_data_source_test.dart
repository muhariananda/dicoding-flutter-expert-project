import 'dart:convert';
import 'dart:io';

import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tv_series_repository/src/models/models.dart';
import 'package:tv_series_repository/tv_series_repository.dart';

import '../json_reader.dart';
import '../test_helper/test_helper.mocks.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;
  late UrlBuilder urlBuilder;

  setUp(() {
    urlBuilder = const UrlBuilder();
    mockHttpClient = MockHttpClient();
    datasource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get now playing tv series,', () {
    final testTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data//on_the_air.json'),
      ),
    ).tvSeriesList;

    test(
      'should return list of TvSeriesModel when the response code 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetNowPlayingTvSeriesUrl()))
            .thenAnswer(
          (_) async =>
              http.Response(readJson('dummy_data//on_the_air.json'), 200),
        );

        //act
        final result = await datasource.getNowPlayingTvSeries();

        //assert
        expect(result, equals(testTvSeriesList));
      },
    );

    test(
      'should return ServerException when status code is 404 or other',
      () {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetNowPlayingTvSeriesUrl()))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //act
        final call = datasource.getNowPlayingTvSeries();

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get popular tv series,', () {
    final testTvSeries = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data//popular_tv_series.json'),
      ),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetPopularTvSeriesUrl()))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data//popular_tv_series.json'), 200),
        );

        //act
        final result = await datasource.getPopularTvSeries();

        //assert
        expect(result, equals(testTvSeries));
      },
    );

    test(
      'should return ServerException when response code is 404 or other',
      () {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetPopularTvSeriesUrl()))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //act
        final call = datasource.getPopularTvSeries();

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get top rated tv series,', () {
    final testTvSeries = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data//top_rated_tv_series.json')),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetTopRatedTvSeriesUrl()))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data//top_rated_tv_series.json'), 200),
        );

        //act
        final result = await datasource.getTopRatedTvSeries();

        //assert
        expect(result, equals(testTvSeries));
      },
    );

    test(
      'should return ServerException when response code is 404 or other',
      () {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetTopRatedTvSeriesUrl()))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //act
        final call = datasource.getTopRatedTvSeries();

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get detail tv series,', () {
    const tId = 1;
    final testTvSeries = TvSeriesDetailResponse.fromJson(
      json.decode(readJson('dummy_data//tv_series_detail.json')),
    );

    test(
      'should return Tv Series Detail Response when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetDetailTvSeriesUrl(tId)))
            .thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data//tv_series_detail.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        //act
        final result = await datasource.getTvSeriesDetail(tId);

        //assert
        expect(result, equals(testTvSeries));
      },
    );

    test(
      'should return ServerException when response code is 404 or other',
      () {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetDetailTvSeriesUrl(tId)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //act
        final call = datasource.getTvSeriesDetail(tId);

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get recommendations tv series,', () {
    const tId = 1;
    final testTvSeries = TvSeriesResponse.fromJson(
      json.decode(readJson('dummy_data//recommendations_tv_series.json')),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient
                .get(urlBuilder.buildGetRecommendationsTvSeriesUrl(tId)))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data//recommendations_tv_series.json'), 200),
        );

        //act
        final result = await datasource.getRecommendationsTvSeries(tId);

        //assert
        expect(result, equals(testTvSeries));
      },
    );

    test('should return ServerException when response code is 404 or other',
        () {
      //arrange
      when(mockHttpClient
              .get(urlBuilder.buildGetRecommendationsTvSeriesUrl(tId)))
          .thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      //act
      final call = datasource.getRecommendationsTvSeries(tId);

      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series,', () {
    const tQuery = 'Chainsaw Man';
    final testTvSeries = TvSeriesResponse.fromJson(json
            .decode(readJson('dummy_data//search_chainsaw_man_tv_series.json')))
        .tvSeriesList;

    test(
      'should return list of Tv Series Model when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildSearchTvSeriesUrl(tQuery)))
            .thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data//search_chainsaw_man_tv_series.json'),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ),
        );

        //act
        final result = await datasource.searchTvSeries(tQuery);

        //assert
        expect(result, equals(testTvSeries));
      },
    );

    test(
      'should return ServerException when response code is other than 200',
      () {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildSearchTvSeriesUrl(tQuery)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        //act
        final call = datasource.searchTvSeries(tQuery);

        //assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
