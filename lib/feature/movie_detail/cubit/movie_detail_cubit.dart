import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailCubit({
    required this.getMovieDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(const MovieDetailState());

  Future<void> fetchMovieDetail(int id) async {
    emit(MovieDetailState());
    final result = await getMovieDetail.execute(id);
    result.fold(
      (failure) {
        emit(
          state.copyWith(errorMessage: failure.message),
        );
      },
      (movie) {
        emit(
          state.copyWith(movie: movie),
        );
      },
    );
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    emit(
      state.copyWith(watchlistStatus: result),
    );
  }

  Future<void> addedToWatchlist(MovieDetail movie) async {
    final result = await saveWatchlist.execute(movie);
    result.fold(
      (failure) {
        emit(state.copyWith(
          upsertStatus: MovieDetailUpsertFailure(failure.message),
        ));
      },
      (successMessage) {
        emit(state.copyWith(
          upsertStatus: MovieDetailUpsertSuccess(successMessage),
        ));
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(MovieDetail movie) async {
    final result = await removeWatchlist.execute(movie);
    result.fold(
      (failure) {
        emit(state.copyWith(
          upsertStatus: MovieDetailUpsertFailure(failure.message),
        ));
      },
      (successMessage) {
        emit(state.copyWith(
          upsertStatus: MovieDetailUpsertSuccess(successMessage),
        ));
      },
    );

    await loadWatchlistStatus(movie.id);
  }
}
