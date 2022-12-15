import 'package:db_sqflite/db_sqflite.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

extension TvSeriesTableToEntity on TvSeriesTable {
  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        name: name ?? '',
        posterPath: posterPath ?? '',
        overview: overview ?? '',
      );
}
