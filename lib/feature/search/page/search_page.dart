import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/feature/search/provider/search_notifier.dart';

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
              key: Key('search_bar'),
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
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  key: Key('movie_filter_chip'),
                  label: Text('Movies'),
                  selected:
                      Provider.of<SearchNotifier>(context).selectedContent ==
                          ContentSelection.movie,
                  onSelected: (_) {
                    context
                        .read<SearchNotifier>()
                        .setSelectedContent(ContentSelection.movie);
                  },
                ),
                FilterChip(
                  key: Key('tv_series_filter_chip'),
                  label: Text('Tv Series'),
                  selected:
                      Provider.of<SearchNotifier>(context).selectedContent ==
                          ContentSelection.tv,
                  onSelected: (_) {
                    context
                        .read<SearchNotifier>()
                        .setSelectedContent(ContentSelection.tv);
                  },
                ),
              ],
            ),
            Expanded(
              child: (Provider.of<SearchNotifier>(context).selectedContent ==
                      ContentSelection.movie)
                  ? _MovieSearchList()
                  : _TvSeriesSearchList(),
            )
          ],
        ),
      ),
    );
  }
}

class _MovieSearchList extends StatelessWidget {
  const _MovieSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(
      builder: (context, value, child) {
        final state = value.movieState;
        if (state == RequestState.Loading) {
          return const CenteredProgressCircularIndicator();
        } else if (state == RequestState.Loaded) {
          return VerticaledMovieList(
            key: Key('movie_listview'),
            movies: value.movieSearchResult,
          );
        } else {
          return CenteredText(
            value.message,
            key: Key('error_message'),
          );
        }
      },
    );
  }
}

class _TvSeriesSearchList extends StatelessWidget {
  const _TvSeriesSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchNotifier>(
      builder: (context, value, child) {
        final state = value.tvSeriesState;
        if (state == RequestState.Loading) {
          return const CenteredProgressCircularIndicator();
        } else if (state == RequestState.Loaded) {
          return VerticaledTvSeriesList(
            key: Key('tv_series_listview'),
            tvSeriesList: value.tvSeriesSearchResult,
          );
        } else {
          return CenteredText(
            value.message,
            key: Key('error_message'),
          );
        }
      },
    );
  }
}
