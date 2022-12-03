import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TopRatedTvSeriesNotifier>().fetchTopRatedTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TopRatedTvSeriesNotifier>(
          builder: (context, value, child) {
            final state = value.topRatedTvSeriesState;
            if (state == RequestState.Loading) {
              return CenteredProgressCircularIndicator();
            } else if (state == RequestState.Loaded) {
              return VerticaledTvSeriesList(
                tvSeriesList: value.topRatedTvSeries,
              );
            } else {
              return CenteredText(
                value.message,
                key: Key('error_message'),
              );
            }
          },
        ),
      ),
    );
  }
}
