import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_domain/movie_domain.dart';

import '../cubit/now_playing_movie_cubit.dart';
import '../cubit/popular_movie_cubit.dart';
import '../cubit/top_rated_movie_cubit.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({Key? key}) : super(key: key);

  @override
  MovieListPageState createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {
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
                  if (state is NowPlayingMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is NowPlayingMovieFailure) {
                    return Text(state.message);
                  } else {
                    return const CenteredProgressCircularIndicator();
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.routeName);
                },
              ),
              BlocBuilder<PopularMovieCubit, PopularMovieState>(
                builder: (context, state) {
                  if (state is PopularMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is PopularMovieFailure) {
                    return Text(state.message);
                  } else {
                    return const CenteredProgressCircularIndicator();
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.routeName);
                },
              ),
              BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieSuccess) {
                    return _MovieList(movies: state.movies);
                  } else if (state is TopRatedMovieFailure) {
                    return Text(state.message);
                  } else {
                    return const CenteredProgressCircularIndicator();
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
    return SizedBox(
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
                  MovieDetailPage.routeName,
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
