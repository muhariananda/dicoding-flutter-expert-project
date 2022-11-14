import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';

class TvSeriesTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvSeriesTable({
    required this.id,
    this.name,
    this.posterPath,
    this.overview,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'posterPath': posterPath,
      'overview': overview,
    };
  }

  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );

  factory TvSeriesTable.fromEntity(TvSeriesDetail tvSeries) => TvSeriesTable(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory TvSeriesTable.fromJson(Map<String, dynamic> json) {
    return TvSeriesTable(
      id: json['id'] as int,
      name: json['name'] != null ? json['name'] as String : null,
      posterPath:
          json['posterPath'] != null ? json['posterPath'] as String : null,
      overview: json['overview'] != null ? json['overview'] as String : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}
