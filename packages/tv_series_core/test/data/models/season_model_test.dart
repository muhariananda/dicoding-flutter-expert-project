import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_core/src/data/mapper/mappers.dart';
import 'package:tv_series_core/tv_series_core.dart';

void main() {
  const tSeasonModel = SeasonModel(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  final tMapSeasonModel = {
    'air_date': 'airDate',
    'episode_count': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': 'posterPath',
    'season_number': 1,
  };

  const tSeason = Season(
    airDate: 'airDate',
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  );

  test('should convert to json from season model class', () {
    final result = tSeasonModel.toJson();
    expect(result, tMapSeasonModel);
  });

  test('should convert season model from model to entity', () {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
