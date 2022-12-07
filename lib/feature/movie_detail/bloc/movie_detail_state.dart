part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final dynamic error;
  final bool watchlistStatus;
  final dynamic watchlistMessage;

  const MovieDetailState({
    this.movie,
    this.error,
    this.watchlistStatus = false,
    this.watchlistMessage,
  });

  MovieDetailState.loading() : this();

  MovieDetailState.success({
    required MovieDetail movie,
  }) : this(movie: movie);

  MovieDetailState.error({
    required String message,
  }) : this(error: message);

  MovieDetailState copyWithNewWatchlistStatus(
    bool watchlistStatus,
  ) =>
      MovieDetailState(
        movie: this.movie,
        error: this.error,
        watchlistStatus: watchlistStatus,
        watchlistMessage: this.watchlistMessage,
      );

  MovieDetailState copyWithNewWatchlistMessage(
    String watchlistMessage,
  ) =>
      MovieDetailState(
        movie: this.movie,
        error: this.error,
        watchlistStatus: this.watchlistStatus,
        watchlistMessage: watchlistMessage,
      );

  @override
  List<Object?> get props => [
        movie,
        error,
        watchlistStatus,
        watchlistMessage,
      ];
}
