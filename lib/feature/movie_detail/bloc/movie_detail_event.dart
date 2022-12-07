part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailOnRequested extends MovieDetailEvent {
  final int id;

  const MovieDetailOnRequested(this.id);

  @override
  List<Object> get props => [id];
}

class MovieDetailOnCheckedWatchlistStatus extends MovieDetailEvent {
  final int id;

  const MovieDetailOnCheckedWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

abstract class MovieDetailWatchlistToggled extends MovieDetailEvent {
  final MovieDetail movie;

  const MovieDetailWatchlistToggled(this.movie);
}

class MovieDetailOnAddedWatchlist extends MovieDetailWatchlistToggled {
  const MovieDetailOnAddedWatchlist(
    MovieDetail movie,
  ) : super(movie);
}

class MovieDetailOnRemovedWatchlist extends MovieDetailWatchlistToggled {
  const MovieDetailOnRemovedWatchlist(
    MovieDetail movie,
  ) : super(movie);
}
