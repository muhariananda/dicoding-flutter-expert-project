part of 'movie_detail_cubit.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final dynamic errorMessage;
  final bool watchlistStatus;
  final MovieDetailUpsertStatus? upsertStatus;

  const MovieDetailState({
    this.movie,
    this.errorMessage,
    this.watchlistStatus = false,
    this.upsertStatus,
  });

  MovieDetailState copyWith({
    MovieDetail? movie,
    dynamic errorMessage,
    bool? watchlistStatus,
    MovieDetailUpsertStatus? upsertStatus,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      errorMessage: errorMessage ?? this.errorMessage,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      upsertStatus: upsertStatus ?? this.upsertStatus,
    );
  }

  @override
  List<Object?> get props => [
        movie,
        errorMessage,
        watchlistStatus,
        upsertStatus,
      ];
}

abstract class MovieDetailUpsertStatus extends Equatable {
  const MovieDetailUpsertStatus();
}

class MovieDetailUpsertSuccess extends MovieDetailUpsertStatus {
  final String message;

  const MovieDetailUpsertSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailUpsertFailure extends MovieDetailUpsertStatus {
  final String error;

  const MovieDetailUpsertFailure(this.error);

  @override
  List<Object?> get props => [error];
}
