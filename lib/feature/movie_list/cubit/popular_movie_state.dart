part of 'popular_movie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();
}

class PopularMovieInProgress extends PopularMovieState {
  const PopularMovieInProgress();

  @override
  List<Object?> get props => [];
}

class PopularMovieSuccess extends PopularMovieState {
  final List<Movie> movies;

  PopularMovieSuccess(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class PopularMovieFailure extends PopularMovieState {
  final String message;

  PopularMovieFailure(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
