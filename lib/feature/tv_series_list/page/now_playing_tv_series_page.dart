import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-tv-series';

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesState();
}

class _NowPlayingTvSeriesState extends State<NowPlayingTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
          builder: (context, state) {
            if (state is NowPayingTvSeriesSuccess) {
              return VerticaledTvSeriesList(tvSeriesList: state.tvSeriesList);
            } else if (state is NowPayingTvSeriesFailure) {
              return CenteredText(state.message);
            } else {
              return const CenteredProgressCircularIndicator();
            }
          },
        ),
      ),
    );
  }
}
