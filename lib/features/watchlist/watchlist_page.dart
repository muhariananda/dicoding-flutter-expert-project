import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/features/watchlist/watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  key: Key('movie_filter_chip'),
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
                  key: Key('tv_series_filter_chip'),
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
            Expanded(
              child:
                  (Provider.of<WatchlistNotifier>(context).contentSelection ==
                          ContentSelection.movie)
                      ? _WatchlistMovieList()
                      : _WatchlistTvSeriesList(),
            )
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

class _WatchlistMovieList extends StatelessWidget {
  const _WatchlistMovieList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistNotifier>(
      builder: (context, value, child) {
        final state = value.movieState;
        if (state == RequestState.Loading) {
          return CircularProgressIndicator();
        } else if (state == RequestState.Loaded) {
          return VerticaledMovieList(
              key: Key('movie_listview'), movies: value.watchlistMovies);
        } else {
          return Text(
            value.message,
            key: Key('error_message'),
          );
        }
      },
    );
  }
}

class _WatchlistTvSeriesList extends StatelessWidget {
  const _WatchlistTvSeriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchlistNotifier>(
      builder: (context, value, child) {
        final state = value.tvSeriesState;
        if (state == RequestState.Loading) {
          return CircularProgressIndicator();
        } else if (state == RequestState.Loaded) {
          return VerticaledTvSeriesList(
            key: Key('tv_series_listview'),
            tvSeriesList: value.watchlistTvSeries,
          );
        } else {
          return Text(
            value.message,
            key: Key('error_message'),
          );
        }
      },
    );
  }
}
