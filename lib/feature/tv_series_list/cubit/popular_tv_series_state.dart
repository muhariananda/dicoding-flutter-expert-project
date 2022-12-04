part of 'popular_tv_series_cubit.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();
}

class PopularTvSeriesInProgress extends PopularTvSeriesState {
  const PopularTvSeriesInProgress();

  @override
  List<Object?> get props => [];
}

class PopularTvSeriesSuccess extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const PopularTvSeriesSuccess(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class PopularTvSeriesFailure extends PopularTvSeriesState {
  final String message;

  const PopularTvSeriesFailure(this.message);

  @override
  List<Object?> get props => [message];
}
