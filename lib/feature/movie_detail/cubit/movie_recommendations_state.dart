part of 'movie_recommendations_cubit.dart';

abstract class MovieRecommendationsState extends Equatable {
  const MovieRecommendationsState();
}

class MovieRecommendationsInProgress extends MovieRecommendationsState {
  const MovieRecommendationsInProgress();

  @override
  List<Object?> get props => [];
}

class MovieRecommendationsSuccess extends MovieRecommendationsState {
  final List<Movie> movies;

  MovieRecommendationsSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class MovieRecommendationsFailure extends MovieRecommendationsState {
  final String message;

  MovieRecommendationsFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
