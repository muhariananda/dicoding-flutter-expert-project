import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';

part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesCubit extends Cubit<TopRatedTvSeriesState> {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesCubit({
    required this.getTopRatedTvSeries,
  }) : super(const TopRatedTvSeriesInProgress());

  Future<void> fetchTopRatedTvSeries() async {
    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        emit(
          TopRatedTvSeriesFailure(failure.message),
        );
      },
      (data) {
        emit(
          TopRatedTvSeriesSuccess(data),
        );
      },
    );
  }
}
