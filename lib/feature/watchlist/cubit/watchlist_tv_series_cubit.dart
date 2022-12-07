import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';

part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesCubit extends Cubit<WatchlistTvSeriesState> {
  final GetWatchListTvSeries getWatchListTvSeries;

  WatchlistTvSeriesCubit({
    required this.getWatchListTvSeries,
  }) : super(const WatchlistTvSeriesInProgress());

  Future<void> fetchWatchlistTvSeries() async {
    final result = await getWatchListTvSeries.execute();
    result.fold(
      (failure) {
        emit(
          WatchlistTvSeriesFailure(message: failure.message),
        );
      },
      (tvSeries) {
        emit(
          WatchlistTvSeriesSuccess(tvSeries: tvSeries),
        );
      },
    );
  }
}
