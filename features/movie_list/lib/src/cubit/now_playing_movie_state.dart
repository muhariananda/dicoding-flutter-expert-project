part of 'now_playing_movie_cubit.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();
}

class NowPlayingMovieInProgress extends NowPlayingMovieState {
  const NowPlayingMovieInProgress();

  @override
  List<Object?> get props => [];
}

class NowPlayingMovieSuccess extends NowPlayingMovieState {
  final List<Movie> movies;

  const NowPlayingMovieSuccess(
    this.movies,
  );

  @override
  List<Object?> get props => [movies];
}

class NowPlayingMovieFailure extends NowPlayingMovieState {
  final String message;

  const NowPlayingMovieFailure(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}
