import 'package:ditonton/core/movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';

part 'movie_upsert_state.dart';

class MovieUpsertCubit extends Cubit<MovieUpsertState> {
  static const addedWatchlistSuccessMessage = 'Added to Watchlist';
  static const removedWatchlistSuccessMessage = 'Removed from Watchlist';

  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieUpsertCubit({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(
          MovieUpsertState(
            isAddetoWatchlist: false,
            watchlistMessage: '',
          ),
        );

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(
      state.copyWith(
        isAddetoWatchlist: result,
      ),
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      },
      (successMessage) {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);
    result.fold(
      (failure) async {
        emit(
          state.copyWith(
            watchlistMessage: failure.message,
          ),
        );
      },
      (successMessage) async {
        emit(
          state.copyWith(
            watchlistMessage: successMessage,
          ),
        );
      },
    );

    await loadWatchlistStatus(movie.id);
  }
}
