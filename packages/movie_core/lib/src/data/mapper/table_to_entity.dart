import 'package:db_sqflite/db_sqflite.dart';

import '../../domain/entities/movie.dart';

extension MovieTableToEntity on MovieTable {
  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview ?? '',
        posterPath: posterPath ?? '',
        title: title ?? '',
      );
}
