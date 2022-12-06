part of 'tv_series_detail_bloc.dart';

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeries;
  final dynamic error;
  final bool watchlistStatus;
  final dynamic watchlistMessage;

  const TvSeriesDetailState({
    this.tvSeries,
    this.error,
    this.watchlistStatus = false,
    this.watchlistMessage,
  });

  TvSeriesDetailState.success({
    required TvSeriesDetail tvSeries,
  }) : this(tvSeries: tvSeries);

  TvSeriesDetailState.error({
    required String message,
  }) : this(error: message);

  TvSeriesDetailState copyWithNewWatchlistStatus(
    bool watchlistStatus,
  ) =>
      TvSeriesDetailState(
        tvSeries: this.tvSeries,
        error: this.error,
        watchlistMessage: this.watchlistMessage,
        watchlistStatus: watchlistStatus,
      );

  TvSeriesDetailState copyWithNewWatchlistMessage(
    dynamic watchlistMessage,
  ) =>
      TvSeriesDetailState(
        tvSeries: this.tvSeries,
        error: this.error,
        watchlistStatus: this.watchlistStatus,
        watchlistMessage: watchlistMessage,
      );

  @override
  List<Object?> get props => [
        tvSeries,
        error,
        watchlistStatus,
        watchlistMessage,
      ];
}
