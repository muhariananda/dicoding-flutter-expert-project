import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_repository/src/models/models.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
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

  final tTvSeriesResponse =
      TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  final tMapTvSeriesResponse = {
    'results': [
      {
        'backdrop_path': 'backdropPath',
        'first_air_date': 'firstAirDate',
        'genre_ids': [1, 2, 3],
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
      }
    ]
  };

  test('should convert to json from tv series response', () {
    final result = tTvSeriesResponse.toJson();
    expect(result, tMapTvSeriesResponse);
  });

  test('should convert to tv series response model from json', () {
    final result = TvSeriesResponse.fromJson(tMapTvSeriesResponse);
    expect(result, tTvSeriesResponse);
  });
}
