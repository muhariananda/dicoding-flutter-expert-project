import 'package:db_sqflite/db_sqflite.dart';

import '../../domain/entities/entittes.dart';

extension TvSeriesDetailEntityToTable on TvSeriesDetail {
  TvSeriesTable toTable() => TvSeriesTable(
        id: id,
        name: name,
        posterPath: posterPath,
        overview: overview,
      );
}
