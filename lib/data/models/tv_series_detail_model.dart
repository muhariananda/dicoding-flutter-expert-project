import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetailResponse extends Equatable {
  TvSeriesDetailResponse({
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
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'backdropPath': backdropPath,
      'firstAirDate': firstAirDate,
      'genreIds': genreIds,
      'id': id,
      'name': name,
      'originCountry': originCountry,
      'originalLanguage': originalLanguage,
      'originalName': originalName,
      'overview': overview,
      'popularity': popularity,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) {
    return TvSeriesDetailResponse(
      backdropPath:
          json['backdropPath'] != null ? json['backdropPath'] as String : null,
      firstAirDate:
          json['firstAirDate'] != null ? json['firstAirDate'] as String : null,
      genreIds: List<int>.from((json['genreIds'] as List<int>)),
      id: json['id'] as int,
      name: json['name'] as String,
      originCountry: json['originCountry'] != null
          ? List<String>.from((json['originCountry'] as List<String>))
          : null,
      originalLanguage: json['originalLanguage'] as String,
      originalName: json['originalName'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath:
          json['posterPath'] != null ? json['posterPath'] as String : null,
      voteAverage: json['voteAverage'] as double,
      voteCount: json['voteCount'] as int,
    );
  }

  TvSeriesDetail toEntity() => TvSeriesDetail(
        backdropPath: this.backdropPath,
        firstAirDate: this.firstAirDate,
        genreIds: this.genreIds,
        id: this.id,
        name: this.name,
        originCountry: this.originCountry,
        originalLanguage: this.originalLanguage,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
      );

  @override
  List<Object?> get props {
    return [
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
}
