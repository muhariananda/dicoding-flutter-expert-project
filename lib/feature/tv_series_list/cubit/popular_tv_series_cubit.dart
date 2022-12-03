import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_popular_tv_series.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesCubit({
    required this.getPopularTvSeries,
  }) : super(PopularTvSeriesState.loading);

  Future<void> fetchPopularTvSeries() async {
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        emit(PopularTvSeriesState.error(failure.message));
      },
      (data) {
        emit(PopularTvSeriesState.success(data));
      },
    );
  }
}
