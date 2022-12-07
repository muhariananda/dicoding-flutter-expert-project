part of 'search_movie_bloc.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovieOnQueryChanged extends SearchMovieEvent {
  final String query;

  const SearchMovieOnQueryChanged({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}
