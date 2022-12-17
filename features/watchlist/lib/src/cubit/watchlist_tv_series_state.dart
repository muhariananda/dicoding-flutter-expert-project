part of 'watchlist_tv_series_cubit.dart';

abstract class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();
}

class WatchlistTvSeriesInProgress extends WatchlistTvSeriesState {
  const WatchlistTvSeriesInProgress();

  @override
  List<Object?> get props => [];
}

class WatchlistTvSeriesSuccess extends WatchlistTvSeriesState {
  final List<TvSeries> tvSeries;

  const WatchlistTvSeriesSuccess({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class WatchlistTvSeriesFailure extends WatchlistTvSeriesState {
  final String message;

  const WatchlistTvSeriesFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
