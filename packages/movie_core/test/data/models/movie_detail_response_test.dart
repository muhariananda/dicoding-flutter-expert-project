import 'package:flutter_test/flutter_test.dart';
import 'package:movie_core/movie_core.dart';

void main() {
  const tMovieDetailResponse = MovieDetailResponse(
    adult: true,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [
      GenreModel(
        id: 1,
        name: 'name',
      )
    ],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1.0,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tMapMovieDetailResponse = {
    'adult': true,
    'backdrop_path': 'backdropPath',
    'budget': 1,
    'genres': [
      {'id': 1, 'name': 'name'}
    ],
    'homepage': 'homepage',
    'id': 1,
    'imdb_id': 'imdbId',
    'original_language': 'originalLanguage',
    'original_title': 'originalTitle',
    'overview': 'overview',
    'popularity': 1.0,
    'poster_path': 'posterPath',
    'release_date': 'releaseDate',
    'revenue': 1,
    'runtime': 1,
    'status': 'status',
    'tagline': 'tagline',
    'title': 'title',
    'video': true,
    'vote_average': 1.0,
    'vote_count': 1,
  };

  test('should to json from movie detail response', () {
    final result = tMovieDetailResponse.toJson();
    expect(result, tMapMovieDetailResponse);
  });
}
