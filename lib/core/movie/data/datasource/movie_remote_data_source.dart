import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/url_builder.dart';
import 'package:ditonton/core/movie/data/models/movie_detail_model.dart';
import 'package:ditonton/core/movie/data/models/movie_model.dart';
import 'package:ditonton/core/movie/data/models/movie_response.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;
  final UrlBuilder _urlBuilder;

  MovieRemoteDataSourceImpl({
    required this.client,
    @visibleForTesting UrlBuilder? urlBuilder,
  }) : _urlBuilder = urlBuilder ?? UrlBuilder();

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response =
        await client.get(_urlBuilder.buildGetNowPlayingMoviesUrl());

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await client.get(_urlBuilder.buildGetMovieDetailUrl(id));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response =
        await client.get(_urlBuilder.buildGetRecommendationsMovieUrl(id));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await client.get(_urlBuilder.buildGetPopularMoviesUrl());

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await client.get(_urlBuilder.buildGetTopRatedMoviesUrl());

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await client.get(_urlBuilder.buildSearchMoviesUrl(query));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
