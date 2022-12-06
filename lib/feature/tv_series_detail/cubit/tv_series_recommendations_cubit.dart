import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_tv_series_recommendations.dart';

part 'tv_series_recommendations_state.dart';

class TvSeriesRecommendationsCubit extends Cubit<TvSeriesRecommendationsState> {
  final GetTvSeriesRecommendations getTvSeriesRecommendations;

  TvSeriesRecommendationsCubit({
    required this.getTvSeriesRecommendations,
  }) : super(const TvSeriesRecommendationsInProgress());

  Future<void> fetchRecommendationsTvSeries(int id) async {
    final result = await getTvSeriesRecommendations.execute(id);
    result.fold(
      (failure) {
        emit(
          TvSeriesRecommendationsFailure(message: failure.message),
        );
      },
      (data) {
        emit(
          TvSeriesRecommendationsSuccess(tvSeries: data),
        );
      },
    );
  }
}
