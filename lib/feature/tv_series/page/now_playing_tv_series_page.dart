import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series/provider/now_playing_tv_series_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesState();
}

class _NowPlayingTvSeriesState extends State<NowPlayingTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          context.read<NowPlayingTvSeriesNotifier>().fetchNowPlayingTvSeries(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<NowPlayingTvSeriesNotifier>(
          builder: (context, value, child) {
            final state = value.state;
            if (state == RequestState.Loading) {
              return CenteredProgressCircularIndicator();
            } else if (state == RequestState.Loaded) {
              return VerticaledTvSeriesList(
                tvSeriesList: value.nowPlayingTvSeries,
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
