import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/usecase/get_now_playing_movies.dart';

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
