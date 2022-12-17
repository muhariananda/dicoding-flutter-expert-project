import 'package:movie_domain/movie_domain.dart';

import '../models/models.dart';

extension MovieModelToEntity on MovieModel {
  Movie toEntity() => Movie(
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}

extension MovieDetailModelToEntity on MovieDetailResponse {
  MovieDetail toEntity() => MovieDetail(
        adult: adult,
        backdropPath: backdropPath,
        genres: genres.map((e) => e.toEntity()).toList(),
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        posterPath: posterPath,
        releaseDate: releaseDate,
        runtime: runtime,
        title: title,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}

extension GenreModelToEntity on GenreModel {
  Genre toEntity() => Genre(
        id: id,
        name: name,
      );
}
