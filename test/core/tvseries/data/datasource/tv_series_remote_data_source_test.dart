import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/url_builder.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_remote_data_source.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;
  late UrlBuilder urlBuilder;

  setUp(() {
    urlBuilder = UrlBuilder();
    mockHttpClient = MockHttpClient();
    datasource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get now playing tv series,', () {
    final testTvSeriesList = TvSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series/on_the_air.json'),
      ),
    ).tvSeriesList;

    test(
      'should return list of TvSeriesModel when the response code 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetNowPlayingTvSeriesUrl()))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tv_series/on_the_air.json'), 200),
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
        readJson('dummy_data/tv_series/popular_tv_series.json'),
      ),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetPopularTvSeriesUrl()))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tv_series/popular_tv_series.json'), 200),
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
      json.decode(readJson('dummy_data/tv_series/top_rated_tv_series.json')),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetTopRatedTvSeriesUrl()))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tv_series/top_rated_tv_series.json'), 200),
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
    final tId = 1;
    final testTvSeries = TvSeriesDetailResponse.fromJson(
      json.decode(readJson('dummy_data/tv_series/tv_series_detail.json')),
    );

    test(
      'should return Tv Series Detail Response when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildGetDetailTvSeriesUrl(tId)))
            .thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series/tv_series_detail.json'),
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
    final tId = 1;
    final testTvSeries = TvSeriesResponse.fromJson(
      json.decode(
          readJson('dummy_data/tv_series/recommendations_tv_series.json')),
    ).tvSeriesList;

    test(
      'shoudl return list of TvSeriesModel when response code is 200',
      () async {
        //arrange
        when(mockHttpClient
                .get(urlBuilder.buildGetRecommendationsTvSeriesUrl(tId)))
            .thenAnswer(
          (_) async => http.Response(
              readJson('dummy_data/tv_series/recommendations_tv_series.json'),
              200),
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
    final tQuery = 'Chainsaw Man';
    final testTvSeries = TvSeriesResponse.fromJson(json.decode(readJson(
            'dummy_data/tv_series/search_chainsaw_man_tv_series.json')))
        .tvSeriesList;

    test(
      'should return list of Tv Series Model when response code is 200',
      () async {
        //arrange
        when(mockHttpClient.get(urlBuilder.buildSearchTvSeriesUrl(tQuery)))
            .thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series/search_chainsaw_man_tv_series.json'),
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
