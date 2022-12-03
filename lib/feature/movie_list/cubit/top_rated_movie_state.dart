part of 'top_rated_movie_cubit.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  static const loading = const Loading();
  factory TopRatedMovieState.success(List<Movie> movies) = Success;
  factory TopRatedMovieState.error(String message) = Error;
}

class Loading extends TopRatedMovieState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class Success extends TopRatedMovieState {
  final List<Movie> movies;

  const Success(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class Error extends TopRatedMovieState {
  final String message;

  Error(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
