import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieCubit, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieInProgress) {
              return const CenteredProgressCircularIndicator();
            } else if (state is PopularMovieSuccess) {
              return VerticaledMovieList(movies: state.movies);
            } else if (state is PopularMovieFailure) {
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
