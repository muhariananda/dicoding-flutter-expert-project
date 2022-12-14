import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';

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
  }) : super(TvSeriesDetailState());

  Future<void> fetchTvSeriesDetail(int id) async {
    emit(TvSeriesDetailState());
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
