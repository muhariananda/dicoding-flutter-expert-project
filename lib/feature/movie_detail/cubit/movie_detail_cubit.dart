import 'package:ditonton/core/movie/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailCubit({
    required this.getMovieDetail,
  }) : super(const MovieDetailInProgress());

  Future<void> fetchMovieDetail(int id) async {
    final result = await getMovieDetail.execute(id);
    result.fold(
      (failure) {
        emit(
          MovieDetailFailure(message: failure.message),
        );
      },
      (data) {
        emit(
          MovieDetailSuccess(movie: data),
        );
      },
    );
  }
}
