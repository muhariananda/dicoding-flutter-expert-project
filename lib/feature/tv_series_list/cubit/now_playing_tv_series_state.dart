part of 'now_playing_tv_series_cubit.dart';

abstract class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  static const loading = const Loading();
  factory NowPlayingTvSeriesState.success(List<TvSeries> tvSeries) = HasData;
  factory NowPlayingTvSeriesState.error(String message) = Error;
}

class Loading extends NowPlayingTvSeriesState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class HasData extends NowPlayingTvSeriesState {
  final List<TvSeries> tvSeriesList;

  const HasData(this.tvSeriesList);

  @override
  List<Object?> get props => [tvSeriesList];
}

class Error extends NowPlayingTvSeriesState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
