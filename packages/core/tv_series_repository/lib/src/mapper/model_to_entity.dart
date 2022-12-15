import 'package:tv_series_domain/tv_series_domain.dart';

import '../models/models.dart';

extension TvSeriesModelToEntity on TvSeriesModel {
  TvSeries toEntity() => TvSeries(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        genreIds: genreIds,
        id: id,
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity.toDouble(),
        posterPath: posterPath,
        voteAverage: voteAverage.toDouble(),
        voteCount: voteCount,
      );
}

extension TvSeriesDetailResponseToEntity on TvSeriesDetailResponse {
  TvSeriesDetail toEntity() => TvSeriesDetail(
        id: id,
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        genres: genres.map((e) => e.toEntity()).toList(),
        seasons: seasons.map((e) => e.toEntity()).toList(),
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}

extension GenreModelToEntity on GenreModel {
  Genre toEntity() => Genre(
        id: id,
        name: name,
      );
}

extension SeasonModelToEntity on SeasonModel {
  Season toEntity() => Season(
        airDate: airDate,
        episodeCount: episodeCount,
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
      );
}
