import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

class TvSeriesModel extends Equatable {
  TvSeriesModel({
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

  factory TvSeriesModel.fromJson(Map<String, dynamic> json) {
    return TvSeriesModel(
      backdropPath: json['backdropPath'] as String,
      firstAirDate: json['firstAirDate'] as String,
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
      posterPath: json['posterPath'] as String,
      voteAverage: json['voteAverage'] as double,
      voteCount: json['voteCount'] as int,
    );
  }

  TvSeries toEntity() => TvSeries(
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
