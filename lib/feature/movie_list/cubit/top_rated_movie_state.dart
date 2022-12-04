part of 'top_rated_movie_cubit.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();
}

class TopRatedMovieInProgress extends TopRatedMovieState {
  const TopRatedMovieInProgress();

  @override
  List<Object?> get props => [];
}

class TopRatedMovieSuccess extends TopRatedMovieState {
  final List<Movie> movies;

  const TopRatedMovieSuccess(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class TopRatedMovieFailure extends TopRatedMovieState {
  final String message;

  TopRatedMovieFailure(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
