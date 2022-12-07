import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:ditonton/core/movie/domain/usecase/search_movies.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies searchMovies;

  SearchMovieBloc({
    required this.searchMovies,
  }) : super(const SearchMoviesIntial()) {
    on<SearchMovieOnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        emit(
          SearchMovieInProgress(),
        );

        final result = await searchMovies.execute(query);
        result.fold(
          (failure) {
            emit(
              SearchMovieFailure(message: failure.message),
            );
          },
          (movies) {
            if (movies.isNotEmpty) {
              emit(
                SearchMovieSuccess(movies: movies),
              );
            } else {
              emit(
                SearchMovieEmpty(),
              );
            }
          },
        );
      },
      transformer: (events, mapper) {
        final debonceStream = events.debounceTime(
          const Duration(milliseconds: 500),
        );
        final restartableTransformer = restartable<SearchMovieOnQueryChanged>();
        return restartableTransformer(debonceStream, mapper);
      },
    );
  }
}
