import 'package:bloc/bloc.dart';
import 'package:ditonton/core/movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(
          const MovieDetailState(),
        ) {
    _registerEventHandler();
  }

  void _registerEventHandler() {
    on<MovieDetailEvent>(
      (event, emitter) async {
        if (event is MovieDetailOnRequested) {
          await _handleMovieDetailOnRequested(emitter, event);
        } else if (event is MovieDetailOnCheckedWatchlistStatus) {
          await _handleMovieDetailOnCheckedWatchlistStatus(emitter, event);
        } else if (event is MovieDetailWatchlistToggled) {
          await _handleMovieDetailWatchlistToggled(emitter, event);
        }
      },
    );
  }

  Future<void> _handleMovieDetailOnRequested(
    Emitter emitter,
    MovieDetailOnRequested event,
  ) async {
    emitter(MovieDetailState.loading());

    final result = await getMovieDetail.execute(event.id);
    result.fold(
      (failure) {
        emitter(
          MovieDetailState.error(message: failure.message),
        );
      },
      (data) {
        emitter(
          MovieDetailState.success(movie: data),
        );
      },
    );
  }

  Future<void> _handleMovieDetailOnCheckedWatchlistStatus(
    Emitter emitter,
    MovieDetailOnCheckedWatchlistStatus event,
  ) async {
    final result = await getWatchListStatus.execute(event.id);
    emitter(
      state.copyWithNewWatchlistStatus(result),
    );
  }

  Future<void> _handleMovieDetailWatchlistToggled(
    Emitter emitter,
    MovieDetailWatchlistToggled event,
  ) async {
    final movie = event.movie;
    final watchlistMessage = (event is MovieDetailOnAddedWatchlist)
        ? await _addedToWatchlist(movie)
        : await _removedWatchlist(movie);
    emitter(
      state.copyWithNewWatchlistMessage(watchlistMessage),
    );
    add(
      MovieDetailOnCheckedWatchlistStatus(movie.id),
    );
  }

  Future<String> _addedToWatchlist(MovieDetail movie) async {
    String message = '';
    final result = await saveWatchlist.execute(movie);
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

  Future<String> _removedWatchlist(MovieDetail movie) async {
    String message = '';
    final result = await removeWatchlist.execute(movie);
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
