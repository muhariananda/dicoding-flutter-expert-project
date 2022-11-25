import 'package:ditonton/components/components.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/core/movie/domain/entities/movie.dart';

class VerticaledMovieList extends StatelessWidget {
  final List<Movie> movies;

  const VerticaledMovieList({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        return MovieCard(
          Key('movie$index'),
          movie);
      },
    );
  }
}
