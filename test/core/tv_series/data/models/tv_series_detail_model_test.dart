import 'package:ditonton/core/tv_series/data/models/genre_model.dart';
import 'package:ditonton/core/tv_series/data/models/season_model.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesDetailResponse = TvSeriesDetailResponse(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genres: [
      GenreModel(
        id: 1,
        name: 'name',
      ),
    ],
    seasons: [
      SeasonModel(
        airDate: 'airDate',
        episodeCount: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
    ],
    id: 1,
    name: 'name',
    originCountry: ['EN'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMapTvSeriesDetailResponse = {
    'backdrop_path': 'backdropPath',
    'first_air_date': 'firstAirDate',
    'genres': [
      {
        'id': 1,
        'name': 'name',
      }
    ],
    'seasons': [
      {
        'air_date': 'airDate',
        'episode_count': 1,
        'id': 1,
        'name': 'name',
        'overview': 'overview',
        'poster_path': 'posterPath',
        'season_number': 1,
      }
    ],
    'id': 1,
    'name': 'name',
    'origin_country': ['EN'],
    'original_language': 'originalLanguage',
    'original_name': 'originalName',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should convert to json from tv series detail response', () {
    final result = tTvSeriesDetailResponse.toJson();
    expect(result, tMapTvSeriesDetailResponse);
  });
}
