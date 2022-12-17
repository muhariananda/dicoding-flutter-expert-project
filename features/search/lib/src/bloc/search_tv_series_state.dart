part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  const SearchTvSeriesState();
}

class SearchTvSeriesInitial extends SearchTvSeriesState {
  const SearchTvSeriesInitial();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesInProgress extends SearchTvSeriesState {
  const SearchTvSeriesInProgress();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesSuccess extends SearchTvSeriesState {
  final List<TvSeries> tvSeries;

  const SearchTvSeriesSuccess({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class SearchTvSeriesEmpty extends SearchTvSeriesState {
  const SearchTvSeriesEmpty();

  @override
  List<Object?> get props => [];
}

class SearchTvSeriesFailure extends SearchTvSeriesState {
  final String message;

  const SearchTvSeriesFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
