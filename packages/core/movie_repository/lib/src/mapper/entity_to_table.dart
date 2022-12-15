import 'package:db_sqflite/db_sqflite.dart';
import 'package:movie_domain/movie_domain.dart';

extension MovieDetailEntityToTable on MovieDetail {
  MovieTable toTable() => MovieTable(
        id: id,
        title: title,
        posterPath: posterPath,
        overview: overview,
      );
}
