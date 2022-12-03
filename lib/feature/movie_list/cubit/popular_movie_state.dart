part of 'popular_movie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  static const loading = const Loading();
  factory PopularMovieState.success(List<Movie> movies) = Success;
  factory PopularMovieState.error(String message) = Error;
}

class Loading extends PopularMovieState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class Success extends PopularMovieState {
  final List<Movie> movies;

  Success(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class Error extends PopularMovieState {
  final String message;

  Error(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
