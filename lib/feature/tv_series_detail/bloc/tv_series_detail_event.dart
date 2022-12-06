part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailOnRequested extends TvSeriesDetailEvent {
  final int id;

  const TvSeriesDetailOnRequested(this.id);

  @override
  List<Object> get props => [id];
}

class TvSeriesDetailOnCheckedWatchlistStatus extends TvSeriesDetailEvent {
  final int id;

  const TvSeriesDetailOnCheckedWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

abstract class TvSeriesDetailWatchlistToggled extends TvSeriesDetailEvent {
  final TvSeriesDetail tvSeries;

  const TvSeriesDetailWatchlistToggled(this.tvSeries);
}

class TvSeriesDetailOnAddedWatchlist extends TvSeriesDetailWatchlistToggled {
  const TvSeriesDetailOnAddedWatchlist(
    TvSeriesDetail tvSeries,
  ) : super(tvSeries);
}

class TvSeriesDetailOnRemovedWatchlist extends TvSeriesDetailWatchlistToggled {
  const TvSeriesDetailOnRemovedWatchlist(
    TvSeriesDetail tvSeries,
  ) : super(tvSeries);
}
