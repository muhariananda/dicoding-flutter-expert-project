import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_domain/movie_domain.dart';

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
