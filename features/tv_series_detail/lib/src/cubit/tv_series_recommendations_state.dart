part of 'tv_series_recommendations_cubit.dart';

abstract class TvSeriesRecommendationsState extends Equatable {
  const TvSeriesRecommendationsState();
}

class TvSeriesRecommendationsInProgress extends TvSeriesRecommendationsState {
  const TvSeriesRecommendationsInProgress();

  @override
  List<Object?> get props => [];
}

class TvSeriesRecommendationsSuccess extends TvSeriesRecommendationsState {
  final List<TvSeries> tvSeries;

  const TvSeriesRecommendationsSuccess({
    required this.tvSeries,
  });

  @override
  List<Object?> get props => [tvSeries];
}

class TvSeriesRecommendationsFailure extends TvSeriesRecommendationsState {
  final String message;

  const TvSeriesRecommendationsFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
