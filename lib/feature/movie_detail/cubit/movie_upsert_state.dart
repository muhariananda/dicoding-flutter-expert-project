part of 'movie_upsert_cubit.dart';

class MovieUpsertState extends Equatable {
  final bool isAddetoWatchlist;
  final String watchlistMessage;

  MovieUpsertState({
    required this.isAddetoWatchlist,
    required this.watchlistMessage,
  });

  MovieUpsertState copyWith({
    bool? isAddetoWatchlist,
    String? watchlistMessage,
  }) {
    return MovieUpsertState(
      isAddetoWatchlist: isAddetoWatchlist ?? this.isAddetoWatchlist,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }

  @override
  List<Object> get props => [
        isAddetoWatchlist,
        watchlistMessage,
      ];
}
