import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/url_builder.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_response.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getNowPlayingTvSeries();
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getRecommendationsTvSeries(int id);
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;
  final UrlBuilder _urlBuilder;

  TvSeriesRemoteDataSourceImpl({
    required this.client,
    @visibleForTesting UrlBuilder? urlBuilder,
  }) : _urlBuilder = urlBuilder ?? UrlBuilder();

  @override
  Future<List<TvSeriesModel>> getNowPlayingTvSeries() async {
    final response =
        await client.get(_urlBuilder.buildGetNowPlayingTvSeriesUrl());

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(_urlBuilder.buildGetPopularTvSeriesUrl());
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response =
        await client.get(_urlBuilder.buildGetTopRatedTvSeriesUrl());
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response =
        await client.get(_urlBuilder.buildGetDetailTvSeriesUrl(id));
    if (response.statusCode == 200) {
      return TvSeriesDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getRecommendationsTvSeries(int id) async {
    final response =
        await client.get(_urlBuilder.buildGetRecommendationsTvSeriesUrl(id));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response =
        await client.get(_urlBuilder.buildSearchTvSeriesUrl(query));
    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
