import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/usecase/get_top_rated_movies.dart';

part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMovieCubit({
    required this.getTopRatedMovies,
  }) : super(const TopRatedMovieInProgress());

  Future<void> fetchTopRatedMovie() async {
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        emit(
          TopRatedMovieFailure(failure.message),
        );
      },
      (data) {
        emit(
          TopRatedMovieSuccess(data),
        );
      },
    );
  }
}