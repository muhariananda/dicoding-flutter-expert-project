import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/search/search_notifier.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchNotifier>()
                  ..fetchMovieSearch(query)
                  ..fetchTvSeriesSearch(query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            Wrap(
              children: [
                FilterChip(
                  label: Text('Movies'),
                  selected:
                      Provider.of<SearchNotifier>(context).selectedContent ==
                          ContentSelection.movie,
                  onSelected: (_) {
                    context
                        .read<SearchNotifier>()
                        .updateSearchContent(ContentSelection.movie);
                  },
                ),
                FilterChip(
                  label: Text('Tv Series'),
                  selected:
                      Provider.of<SearchNotifier>(context).selectedContent ==
                          ContentSelection.tv,
                  onSelected: (_) {
                    context
                        .read<SearchNotifier>()
                        .updateSearchContent(ContentSelection.tv);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<SearchNotifier>(
              builder: (context, data, child) {
                if (data.movieState == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (data.movieState == RequestState.Loaded) {
                  final movies = data.movieSearchResult;
                  final tvSeries = data.tvSeriesSearchResult;
                  return Expanded(
                    child: (data.selectedContent == ContentSelection.movie)
                        ? SearchMovieList(movies: movies)
                        : SearchTvSeriesList(tvSeriesList: tvSeries),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchMovieList extends StatelessWidget {
  final List<Movie> movies;

  const SearchMovieList({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) {
        final movie = movies[index];
        return MovieCard(movie);
      },
    );
  }
}

class SearchTvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const SearchTvSeriesList({
    Key? key,
    required this.tvSeriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tvSeriesList.length,
      itemBuilder: (BuildContext context, int index) {
        final tvSeries = tvSeriesList[index];
        return TvSeriesCard(tvSeries);
      },
    );
  }
}
