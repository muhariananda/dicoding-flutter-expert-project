part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailInProgress extends MovieDetailState {
  const MovieDetailInProgress();

  @override
  List<Object?> get props => [];
}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetail movie;

  MovieDetailSuccess({
    required this.movie,
  });

  @override
  List<Object?> get props => [movie];
}

class MovieDetailFailure extends MovieDetailState {
  final String message;

  MovieDetailFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
