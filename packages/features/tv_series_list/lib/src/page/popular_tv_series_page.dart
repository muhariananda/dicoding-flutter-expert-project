import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/popular_tv_series_cubit.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({super.key});

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Sereis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
          builder: (context, state) {
            if (state is PopularTvSeriesInProgress) {
              return const CenteredProgressCircularIndicator();
            } else if (state is PopularTvSeriesSuccess) {
              return VerticaledTvSeriesList(tvSeriesList: state.tvSeries);
            } else if (state is PopularTvSeriesFailure) {
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
