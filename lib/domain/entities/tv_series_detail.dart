import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/genre.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.id,
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.seasons,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  String? firstAirDate;
  List<Genre>? genres;
  List<Season>? seasons;
  int id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genres,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}