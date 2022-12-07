import 'package:bloc/bloc.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart';

part 'watchlist_movie_state.dart';

class WatchlistMovieCubit extends Cubit<WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieCubit({
    required this.getWatchlistMovies,
  }) : super(const WatchlistMovieInProgress());

  Future<void> fetchWatchlistMovies() async {
    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        emit(
          WatchlistMovieFailure(message: failure.message),
        );
      },
      (movies) {
        emit(
          WatchlistMovieSuccess(movies: movies),
        );
      },
    );
  }
}
