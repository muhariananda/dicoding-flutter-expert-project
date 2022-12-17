part of 'top_rated_tv_series_cubit.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();
}

class TopRatedTvSeriesInProgress extends TopRatedTvSeriesState {
  const TopRatedTvSeriesInProgress();

  @override
  List<Object?> get props => [];
}

class TopRatedTvSeriesSuccess extends TopRatedTvSeriesState {
  final List<TvSeries> tvSeries;

  const TopRatedTvSeriesSuccess(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class TopRatedTvSeriesFailure extends TopRatedTvSeriesState {
  final String message;

  const TopRatedTvSeriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
