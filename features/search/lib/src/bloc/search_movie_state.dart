part of 'search_movie_bloc.dart';

abstract class SearchMovieState extends Equatable {
  const SearchMovieState();
}

class SearchMoviesIntial extends SearchMovieState {
  const SearchMoviesIntial();

  @override
  List<Object?> get props => [];
}

class SearchMovieInProgress extends SearchMovieState {
  const SearchMovieInProgress();

  @override
  List<Object?> get props => [];
}

class SearchMovieSuccess extends SearchMovieState {
  final List<Movie> movies;

  const SearchMovieSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class SearchMovieEmpty extends SearchMovieState {
  const SearchMovieEmpty();

  @override
  List<Object?> get props => [];
}

class SearchMovieFailure extends SearchMovieState {
  final String message;

  const SearchMovieFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
