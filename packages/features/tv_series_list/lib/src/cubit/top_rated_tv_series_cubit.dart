import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

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
