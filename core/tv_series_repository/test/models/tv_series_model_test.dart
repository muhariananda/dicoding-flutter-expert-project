import 'package:tv_series_repository/src/models/models.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
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

  final tMapTvSeriesModel = {
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
  };

  test('should convert to json from tv series model', () {
    final result = tTvSeriesModel.toJson();
    expect(result, tMapTvSeriesModel);
  });
}
