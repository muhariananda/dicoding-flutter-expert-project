import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
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
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Wrap(
              spacing: 10,
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
            Consumer<SearchNotifier>(
              builder: (context, data, child) {
                if (data.movieState == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (data.movieState == RequestState.Loaded) {
                  final movies = data.movieSearchResult;
                  final tvSeries = data.tvSeriesSearchResult;
                  return Expanded(
                    child: (data.selectedContent == ContentSelection.movie)
                        ? VerticaledMovieList(movies: movies)
                        : VerticaledTvSeriesList(tvSeriesList: tvSeries),
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
