import 'package:db_sqflite/db_sqflite.dart';

import '../../domain/entities/movie_detail.dart';

extension MovieDetailEntityToTable on MovieDetail {
  MovieTable toTable() => MovieTable(
        id: id,
        title: title,
        posterPath: posterPath,
        overview: overview,
      );
}
