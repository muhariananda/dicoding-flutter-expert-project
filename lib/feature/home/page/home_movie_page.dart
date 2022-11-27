import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/feature/movie/page/movie_detail_page.dart';
import 'package:ditonton/feature/home/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/movie/page/popular_movies_page.dart';
import 'package:ditonton/feature/movie/page/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies(),
    );
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
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (state == RequestState.Loaded) {
                  return _MovieList(movies: data.nowPlayingMovies);
                } else {
                  return Text(
                    'Failed',
                    key: Key('error_message'),
                  );
                }
              }),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME);
                },
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (state == RequestState.Loaded) {
                  return _MovieList(movies: data.popularMovies);
                } else {
                  return Text(
                    'Failed',
                    key: Key('error_message'),
                  );
                }
              }),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME);
                },
              ),
              Consumer<MovieListNotifier>(builder: (context, data, child) {
                final state = data.topRatedMoviesState;
                if (state == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (state == RequestState.Loaded) {
                  return _MovieList(movies: data.topRatedMovies);
                } else {
                  return Text(
                    'Failed',
                    key: Key('error_message'),
                  );
                }
              }),
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
