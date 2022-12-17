
import 'package:common/common.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/watchlist_movie_cubit.dart';
import '../cubit/watchlist_tv_series_cubit.dart';

class WatchlistPage extends StatefulWidget {
  static const routeName = '/watchlist-movie';

  const WatchlistPage({super.key});

  @override
  WatchlistPageState createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> with RouteAware {
  WatchlistMovieCubit get _watchlistMovieCubit =>
      context.read<WatchlistMovieCubit>();
  WatchlistTvSeriesCubit get _watchlistTvSeriesCubit =>
      context.read<WatchlistTvSeriesCubit>();
  Tag _tag = Tag.movie;

  @override
  void initState() {
    super.initState();
    _watchlistMovieCubit.fetchWatchlistMovies();
    _watchlistTvSeriesCubit.fetchWatchlistTvSeries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    _watchlistMovieCubit.fetchWatchlistMovies();
    _watchlistTvSeriesCubit.fetchWatchlistTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
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
                  key: const Key('movie_filter_chip'),
                  label: const Text('Movie'),
                  selected: _tag == Tag.movie,
                  onSelected: (_) {
                    setState(() {
                      _tag = Tag.movie;
                    });
                  },
                ),
                FilterChip(
                  key: const Key('tv_series_filter_chip'),
                  label: const Text('Tv Series'),
                  selected: _tag == Tag.tv,
                  onSelected: (_) {
                    setState(() {
                      _tag = Tag.tv;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: (_tag == Tag.movie)
                  ? const _WatchlistMovieList()
                  : const _WatchlistTvSeriesList(),
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
    return BlocBuilder<WatchlistMovieCubit, WatchlistMovieState>(
      builder: (context, state) {
        if (state is WatchlistMovieSuccess) {
          return VerticaledMovieList(
            key: const Key('movie_list_view'),
            movies: state.movies,
          );
        } else if (state is WatchlistMovieFailure) {
          return CenteredText(state.message);
        } else {
          return const CenteredProgressCircularIndicator();
        }
      },
    );
  }
}

class _WatchlistTvSeriesList extends StatelessWidget {
  const _WatchlistTvSeriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistTvSeriesCubit, WatchlistTvSeriesState>(
      builder: (context, state) {
        if (state is WatchlistTvSeriesSuccess) {
          return VerticaledTvSeriesList(
            key: const Key('tv_series_list_view'),
            tvSeriesList: state.tvSeries,
          );
        } else if (state is WatchlistTvSeriesFailure) {
          return CenteredText(state.message);
        } else {
          return const CenteredProgressCircularIndicator();
        }
      },
    );
  }
}
