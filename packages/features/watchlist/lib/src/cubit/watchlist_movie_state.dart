part of 'watchlist_movie_cubit.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
}

class WatchlistMovieInProgress extends WatchlistMovieState {
  const WatchlistMovieInProgress();

  @override
  List<Object?> get props => [];
}

class WatchlistMovieSuccess extends WatchlistMovieState {
  final List<Movie> movies;

  const WatchlistMovieSuccess({
    required this.movies,
  });

  @override
  List<Object?> get props => [movies];
}

class WatchlistMovieFailure extends WatchlistMovieState {
  final String message;

  const WatchlistMovieFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
