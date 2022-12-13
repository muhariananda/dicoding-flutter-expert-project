import 'package:bloc/bloc.dart';

import 'package:ditonton/core/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetDetailTvSeries getDetailTvSeries;
  final GetWatchlistStatus getWatchlistStatus;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;

  TvSeriesDetailBloc({
    required this.getDetailTvSeries,
    required this.getWatchlistStatus,
    required this.saveWatchlistTvSeries,
    required this.removeWatchlistTvSeries,
  }) : super(
          const TvSeriesDetailState(),
        ) {
    _registerEventHandler();
  }

  void _registerEventHandler() {
    on<TvSeriesDetailEvent>(
      (event, emitter) async {
        if (event is TvSeriesDetailOnRequested) {
          await _handleTvSeriesDetailOnRequested(emitter, event);
        } else if (event is TvSeriesDetailOnCheckedWatchlistStatus) {
          await _handleTvSeriesDetailOnCheckedWatchlistStatus(emitter, event);
        } else if (event is TvSeriesDetailWatchlistToggled) {
          await _handleTvSeriesDetailToggled(emitter, event);
        }
      },
    );
  }

  Future<void> _handleTvSeriesDetailOnRequested(
    Emitter emitter,
    TvSeriesDetailOnRequested event,
  ) async {
    emitter(TvSeriesDetailState());

    final result = await getDetailTvSeries.execute(event.id);
    result.fold(
      (failure) {
        emitter(
          state.copyWith(errorMessage: failure.message),
        );
      },
      (data) {
        emitter(
          state.copyWith(tvSeries: data),
        );
      },
    );
  }

  Future<void> _handleTvSeriesDetailOnCheckedWatchlistStatus(
    Emitter emitter,
    TvSeriesDetailOnCheckedWatchlistStatus event,
  ) async {
    final result = await getWatchlistStatus.execute(event.id);

    emitter(
      state.copyWith(watchlistStatus: result),
    );
  }

  Future<void> _handleTvSeriesDetailToggled(
    Emitter emitter,
    TvSeriesDetailWatchlistToggled event,
  ) async {
    final tvSeries = event.tvSeries;
    final result = (event is TvSeriesDetailOnAddedWatchlist)
        ? await saveWatchlistTvSeries.execute(tvSeries)
        : await removeWatchlistTvSeries.execute(tvSeries);

    result.fold(
      (failure) {
        emitter(
          state.copyWith(
            upsertStatus: TvSeriesDetailUpsertFailure(failure.message),
          ),
        );
      },
      (successMessage) {
        emitter(
          state.copyWith(
            upsertStatus: TvSeriesDetailUpsertSuccess(successMessage),
          ),
        );
      },
    );
    add(
      TvSeriesDetailOnCheckedWatchlistStatus(tvSeries.id),
    );
  }
}
