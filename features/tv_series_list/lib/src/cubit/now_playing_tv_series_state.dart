part of 'now_playing_tv_series_cubit.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();
}

class NowPayingTvSeriesInProgress extends NowPlayingTvSeriesState {
  const NowPayingTvSeriesInProgress();

  @override
  List<Object?> get props => [];
}

class NowPayingTvSeriesSuccess extends NowPlayingTvSeriesState {
  final List<TvSeries> tvSeriesList;

  const NowPayingTvSeriesSuccess(this.tvSeriesList);

  @override
  List<Object?> get props => [tvSeriesList];
}

class NowPayingTvSeriesFailure extends NowPlayingTvSeriesState {
  final String message;

  const NowPayingTvSeriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
