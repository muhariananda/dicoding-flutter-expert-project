import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_core/tv_series_core.dart';

part 'tv_series_detail_state.dart';

class TvSeriesDetailCubit extends Cubit<TvSeriesDetailState> {
  final GetDetailTvSeries getDetailTvSeries;
  final GetWatchlistStatus getWatchlistStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailCubit({
    required this.getDetailTvSeries,
    required this.getWatchlistStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(const TvSeriesDetailState());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(const TvSeriesDetailState());
    final result = await getDetailTvSeries.execute(id);
    result.fold(
      (failure) {
        emit(
          state.copyWith(errorMessage: failure.message),
        );
      },
      (tvSeries) {
        emit(
          state.copyWith(tvSeries: tvSeries),
        );
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistStatus.execute(id);
    emit(
      state.copyWith(watchlistStatus: result),
    );
  }

  Future<void> addedToWatchlist(TvSeriesDetail tvSeries) async {
    final result = await saveWatchlistTvSeries.execute(tvSeries);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
              upsertStatus: TvSeriesDetailUpsertFailure(failure.message)),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
              upsertStatus: TvSeriesDetailUpsertSuccess(successMessage)),
        );
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeWatchlistTvSeries.execute(tvSeries);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
              upsertStatus: TvSeriesDetailUpsertFailure(failure.message)),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
              upsertStatus: TvSeriesDetailUpsertSuccess(successMessage)),
        );
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }
}
