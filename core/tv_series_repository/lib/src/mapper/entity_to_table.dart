import 'package:db_sqflite/db_sqflite.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

extension TvSeriesDetailEntityToTable on TvSeriesDetail {
  TvSeriesTable toTable() => TvSeriesTable(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );
}
