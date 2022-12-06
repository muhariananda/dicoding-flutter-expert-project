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
          await _handleTvSeriesDetailWatchlistToggled(emitter, event);
        }
      },
    );
  }

  Future<void> _handleTvSeriesDetailOnRequested(
    Emitter emitter,
    TvSeriesDetailOnRequested event,
  ) async {
    emitter(
      TvSeriesDetailState(),
    );
    
    final result = await getDetailTvSeries.execute(event.id);
    result.fold(
      (failure) {
        emitter(
          TvSeriesDetailState.error(message: failure.message),
        );
      },
      (data) {
        emitter(
          TvSeriesDetailState.success(tvSeries: data),
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
      state.copyWithNewWatchlistStatus(result),
    );
  }

  Future<void> _handleTvSeriesDetailWatchlistToggled(
    Emitter emitter,
    TvSeriesDetailWatchlistToggled event,
  ) async {
    final tvSeries = event.tvSeries;
    final watchlistMessage = (event is TvSeriesDetailOnAddedWatchlist)
        ? await _addedToWatchlist(tvSeries)
        : await _removeWatchlist(tvSeries);
    emitter(
      state.copyWithNewWatchlistMessage(watchlistMessage),
    );
    add(
      TvSeriesDetailOnCheckedWatchlistStatus(tvSeries.id),
    );
  }

  Future<String> _addedToWatchlist(TvSeriesDetail tvSeries) async {
    String message = '';
    final result = await saveWatchlistTvSeries.execute(tvSeries);
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );
    return message;
  }

  Future<String> _removeWatchlist(TvSeriesDetail tvSeries) async {
    String message = '';
    final result = await removeWatchlistTvSeries.execute(tvSeries);
    result.fold(
      (failure) {
        message = failure.message;
      },
      (successMessage) {
        message = successMessage;
      },
    );
    return message;
  }
}
