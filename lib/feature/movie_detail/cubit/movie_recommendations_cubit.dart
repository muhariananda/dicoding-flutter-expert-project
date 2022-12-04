import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/usecase/get_movie_recommendations.dart';

part 'movie_recommendations_state.dart';

class MovieRecommendationsCubit extends Cubit<MovieRecommendationsState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationsCubit({
    required this.getMovieRecommendations,
  }) : super(const MovieRecommendationsInProgress());

  Future<void> fetchMovieRecommendations(int id) async {
    final result = await getMovieRecommendations.execute(id);
    result.fold(
      (failure) {
        emit(
          MovieRecommendationsFailure(message: failure.message),
        );
      },
      (data) {
        emit(
          MovieRecommendationsSuccess(movies: data),
        );
      },
    );
  }
}
