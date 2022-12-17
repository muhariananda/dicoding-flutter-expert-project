import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/now_playing_tv_series_cubit.dart';

class NowPlayingTvSeriesPage extends StatefulWidget {
  static const routeName = '/now-playing-tv-series';

  const NowPlayingTvSeriesPage({super.key});

  @override
  State<NowPlayingTvSeriesPage> createState() => _NowPlayingTvSeriesState();
}

class _NowPlayingTvSeriesState extends State<NowPlayingTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing Tv Series'),
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
