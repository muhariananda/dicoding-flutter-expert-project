import 'package:equatable/equatable.dart';

import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genres,
    required this.seasons,
    required this.id,
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

  final String? backdropPath;
  final String? firstAirDate;
  final List<GenreModel> genres;
  final List<SeasonModel> seasons;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genres': genres.map((x) => x.toJson()).toList(),
      'seasons': seasons.map((x) => x.toJson()).toList(),
      'id': id,
      'name': name,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesDetailResponse(
      backdropPath: json['backdrop_path'] != null
          ? json['backdrop_path'] as String
          : null,
      firstAirDate: json['first_air_date'] != null
          ? json['first_air_date'] as String
          : null,
      genres: List<GenreModel>.from(
        (json['genres'] as List<dynamic>).map<GenreModel>(
          (x) => GenreModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      seasons: List<SeasonModel>.from(
        (json['seasons'] as List<dynamic>).map<SeasonModel>(
          (x) => SeasonModel.fromJson(x as Map<String, dynamic>),
        ),
      ),
      id: json['id'] as int,
      name: json['name'] as String,
      originCountry: json['origin_country'] != null
          ? List<String>.from((json['origin_country'] as List<dynamic>))
          : null,
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath:
          json['poster_path'] != null ? json['poster_path'] as String : null,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
    );
  }

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

  @override
  List<Object?> get props {
    return [
      backdropPath,
      firstAirDate,
      genres,
      seasons,
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
}
