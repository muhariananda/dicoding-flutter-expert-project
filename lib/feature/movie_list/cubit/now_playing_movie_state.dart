part of 'now_playing_movie_cubit.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  static const loading = const Loading();
  factory NowPlayingMovieState.success(List<Movie> movies) = Success;
  factory NowPlayingMovieState.error(String message) = Error;
}

class Loading extends NowPlayingMovieState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class Success extends NowPlayingMovieState {
  final List<Movie> movies;

  const Success(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class Error extends NowPlayingMovieState {
  final String message;

  const Error(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
