import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/features/watchlist/watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<WatchlistNotifier>()
        ..fetchWatchlistMovies()
        ..fetchWatchlistTvSeries(),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistNotifier>()
      ..fetchWatchlistMovies()
      ..fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  label: Text('Movie'),
                  selected: Provider.of<WatchlistNotifier>(context)
                          .contentSelection ==
                      ContentSelection.movie,
                  onSelected: (_) {
                    context
                        .read<WatchlistNotifier>()
                        .setSelectedContent(ContentSelection.movie);
                  },
                ),
                FilterChip(
                  label: Text('Tv Series'),
                  selected: Provider.of<WatchlistNotifier>(context)
                          .contentSelection ==
                      ContentSelection.tv,
                  onSelected: (_) {
                    context
                        .read<WatchlistNotifier>()
                        .setSelectedContent(ContentSelection.tv);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Consumer<WatchlistNotifier>(
              builder: (context, data, child) {
                if (data.movieState == RequestState.Loading) {
                  return CenteredProgressCircularIndicator();
                } else if (data.movieState == RequestState.Loaded) {
                  final movies = data.watchlistMovies;
                  final tvSeries = data.watchlistTvSeries;
                  return (data.contentSelection == ContentSelection.movie)
                      ? VerticaledMovieList(movies: movies)
                      : VerticaledTvSeriesList(tvSeriesList: tvSeries);
                } else {
                  return CenteredText(
                    data.message,
                    key: Key('error-message'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
