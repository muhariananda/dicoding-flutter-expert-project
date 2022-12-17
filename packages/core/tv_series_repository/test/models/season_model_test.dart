
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series_domain/tv_series_domain.dart';
import 'package:tv_series_repository/src/mapper/mappers.dart';
import 'package:tv_series_repository/src/models/models.dart';

void main() {
  final tSeasonModel = SeasonModel(
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

  final tSeason = Season(
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

  test('should to season entity from season model', () {
    final result = tSeasonModel.toEntity();
    expect(result, tSeason);
  });
}
