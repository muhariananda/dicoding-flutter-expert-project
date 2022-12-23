import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_core/movie_core.dart';

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
