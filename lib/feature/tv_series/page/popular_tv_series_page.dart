import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series/provider/popular_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<PopularTvSeriesNotifier>().fetchPopularTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Sereis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<PopularTvSeriesNotifier>(
          builder: (context, value, child) {
            final state = value.popularTvSeriesState;
            if (state == RequestState.Loading) {
              return CenteredProgressCircularIndicator();
            } else if (state == RequestState.Loaded) {
              return VerticaledTvSeriesList(
                tvSeriesList: value.popularTvSeries,
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
