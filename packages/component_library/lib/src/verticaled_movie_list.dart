import 'package:flutter/material.dart';
import 'package:movie_core/movie_core.dart';
import 'package:movie_detail/movie_detail.dart';

import '../component_library.dart';

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
          key: Key('movie$index'),
          movie: movie,
          onTap: () {
            Navigator.pushNamed(
              context,
              MovieDetailPage.routeName,
              arguments: movie.id,
            );
          },
        );
      },
    );
  }
}
