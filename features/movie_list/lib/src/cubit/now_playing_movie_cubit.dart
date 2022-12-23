import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_core/movie_core.dart';

part 'now_playing_movie_state.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieCubit({
    required this.getNowPlayingMovies,
  }) : super(const NowPlayingMovieInProgress());

  Future<void> fetchNowPlayingMovie() async {
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        emit(
          NowPlayingMovieFailure(failure.message),
        );
      },
      (movies) {
        emit(
          NowPlayingMovieSuccess(movies),
        );
      },
    );
  }
}
