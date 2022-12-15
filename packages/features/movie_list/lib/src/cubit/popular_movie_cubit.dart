import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_domain/movie_domain.dart';

part 'popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieCubit({
    required this.getPopularMovies,
  }) : super(const PopularMovieInProgress());

  Future<void> fetchPopularMovies() async {
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        emit(
          PopularMovieFailure(failure.message),
        );
      },
      (data) {
        emit(
          PopularMovieSuccess(data),
        );
      },
    );
  }
}
