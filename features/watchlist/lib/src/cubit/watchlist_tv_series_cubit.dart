import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_core/tv_series_core.dart';

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
