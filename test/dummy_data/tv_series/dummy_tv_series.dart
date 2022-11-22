import 'package:ditonton/core/tv_series/data/models/tv_series_table.dart';
import 'package:ditonton/core/tv_series/domain/entities/genre.dart';
import 'package:ditonton/core/tv_series/domain/entities/season.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series_detail.dart';

final testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeriesWatchlist = TvSeries.watchList(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvSeries = TvSeries(
  backdropPath: 'backdropPath',
  firstAirDate: 'firstAirDate',
  genreIds: [1, 2, 3, 4],
  id: 1,
  name: 'name',
  originCountry: ["EN"],
  originalLanguage: 'en',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);

final testTvSeriesList = <TvSeries>[testTvSeries];

final testTvSeriesMap = {
  'id': 1,
  'name': 'name',
  'overview': 'overview',
  'posterPath': 'posterPath',
};

final testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'path.jpg',
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'name')],
  seasons: [
    Season(
      airDate: 'airDate',
      episodeCount: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 1,
    )
  ],
  id: 1,
  name: 'name',
  originCountry: ['en'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  overview: 'overview',
  popularity: 1.0,
  posterPath: 'posterPath',
  voteAverage: 1.0,
  voteCount: 1,
);
