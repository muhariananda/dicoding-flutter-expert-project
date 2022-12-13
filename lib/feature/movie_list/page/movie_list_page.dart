import 'package:ditonton/feature/movie_list/cubit/now_playing_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/feature/movie_detail/page/movie_detail_page.dart';
import 'package:ditonton/feature/movie_list/page/popular_movies_page.dart';
import 'package:ditonton/feature/movie_list/page/top_rated_movies_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  NowPlayingMovieCubit get _nowPlayingCubit =>
      context.read<NowPlayingMovieCubit>();
  PopularMovieCubit get _popularCubit => context.read<PopularMovieCubit>();
  TopRatedMovieCubit get _topRatedCubit => context.read<TopRatedMovieCubit>();

  @override
  void initState() {
    super.initState();
    _nowPlayingCubit.fetchNowPlayingMovie();
    _popularCubit.fetchPopularMovies();
    _topRatedCubit.fetchTopRatedMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieCubit, NowPlayingMovieState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is NowPlayingMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is NowPlayingMovieFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<PopularMovieCubit, PopularMovieState>(
                builder: (context, state) {
                  if (state is PopularMovieInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is PopularMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is PopularMovieFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is TopRatedMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is TopRatedMovieFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MovieList extends StatelessWidget {
  final List<Movie> movies;

  const _MovieList({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ContentTile(
              imageUrl: movie.posterPath ?? '',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
