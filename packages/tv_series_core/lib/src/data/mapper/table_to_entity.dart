import 'package:db_sqflite/db_sqflite.dart';

import '../../domain/entities/entittes.dart';

extension TvSeriesTableToEntity on TvSeriesTable {
  TvSeries toEntity() => TvSeries.watchList(
        id: id,
        name: name ?? '',
        posterPath: posterPath ?? '',
        overview: overview ?? '',
      );
}
