part of 'top_rated_tv_series_cubit.dart';

abstract class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  static const loading = const Loading();
  factory TopRatedTvSeriesState.success(List<TvSeries> tvSeries) = HasData;
  factory TopRatedTvSeriesState.error(String message) = Error;
}

class Loading extends TopRatedTvSeriesState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class HasData extends TopRatedTvSeriesState {
  final List<TvSeries> tvSeries;

  const HasData(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class Error extends TopRatedTvSeriesState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
