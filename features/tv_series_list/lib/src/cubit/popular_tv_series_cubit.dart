import 'package:tv_series_domain/tv_series_domain.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_tv_series_state.dart';

class PopularTvSeriesCubit extends Cubit<PopularTvSeriesState> {
  final GetPopularTvSeries getPopularTvSeries;

  PopularTvSeriesCubit({
    required this.getPopularTvSeries,
  }) : super(const PopularTvSeriesInProgress());

  Future<void> fetchPopularTvSeries() async {
    final result = await getPopularTvSeries.execute();
    result.fold(
      (failure) {
        emit(
          PopularTvSeriesFailure(failure.message),
        );
      },
      (data) {
        emit(
          PopularTvSeriesSuccess(data),
        );
      },
    );
  }
}
