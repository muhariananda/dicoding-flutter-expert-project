import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
          builder: (context, state) {
            if (state is TopRatedMovieInProgress) {
              return const CenteredProgressCircularIndicator();
            } else if (state is TopRatedMovieSuccess) {
              return VerticaledMovieList(movies: state.movies);
            } else if (state is TopRatedMovieFailure) {
              return CenteredText(
                state.message,
                key: Key('error_message'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
