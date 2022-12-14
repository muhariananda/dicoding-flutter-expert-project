import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  const TvSeriesModel({
    required this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
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
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final num popularity;
  final String? posterPath;
  final num voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'backdrop_path': backdropPath,
      'first_air_date': firstAirDate,
      'genre_ids': genreIds,
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

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      backdropPath: json['backdrop_path'] != null
          ? json['backdrop_path'] as String
          : null,
      firstAirDate: json['first_air_date'] != null
          ? json['first_air_date'] as String
          : null,
      genreIds: List<int>.from((json['genre_ids'] as List<dynamic>)),
      id: json['id'] as int,
      name: json['name'] as String,
      originCountry: json['origin_country'] != null
          ? List<String>.from((json['origin_country'] as List<dynamic>))
          : null,
      originalLanguage: json['original_language'] as String,
      originalName: json['original_name'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as num,
      posterPath:
          json['poster_path'] != null ? json['poster_path'] as String : null,
      voteAverage: json['vote_average'] as num,
      voteCount: json['vote_count'] as int,
    );
  }

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
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
