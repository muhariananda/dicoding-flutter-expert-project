import 'package:tv_series_core/tv_series_core.dart';

const testTvSeries = TvSeries(
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

const testSeason = Season(
  airDate: 'airDate',
  episodeCount: 1,
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  seasonNumber: 1,
);

const testTvSeriesDetail = TvSeriesDetail(
  backdropPath: 'path.jpg',
  firstAirDate: 'firstAirDate',
  genres: [Genre(id: 1, name: 'name')],
  seasons: [testSeason],
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
