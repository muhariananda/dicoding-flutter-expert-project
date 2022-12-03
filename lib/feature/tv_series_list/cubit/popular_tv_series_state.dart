part of 'popular_tv_series_cubit.dart';

abstract class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  static const loading = const Loading();
  factory PopularTvSeriesState.success(List<TvSeries> tvSeries) = HasData;
  factory PopularTvSeriesState.error(String message) = Error;
}

class Loading extends PopularTvSeriesState {
  const Loading();

  @override
  List<Object?> get props => [];
}

class HasData extends PopularTvSeriesState {
  final List<TvSeries> tvSeries;

  const HasData(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}

class Error extends PopularTvSeriesState {
  final String message;

  const Error(this.message);

  @override
  List<Object?> get props => [message];
}
