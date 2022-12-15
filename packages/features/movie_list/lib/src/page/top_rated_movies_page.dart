import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/top_rated_movie_cubit.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({super.key});

  @override
  TopRatedMoviesPageState createState() => TopRatedMoviesPageState();
}

class TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieSuccess) {
              return VerticaledMovieList(movies: state.movies);
            } else if (state is TopRatedMovieFailure) {
              return CenteredText(state.message);
            } else {
              return const CenteredProgressCircularIndicator();
            }
          },
        ),
      ),
    );
  }
}
