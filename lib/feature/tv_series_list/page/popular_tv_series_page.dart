import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  State<PopularTvSeriesPage> createState() => _PopularTvSeriesPageState();
}

class _PopularTvSeriesPageState extends State<PopularTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Sereis'),
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
              return CenteredText(
                state.message,
                key: Key('error_message'),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
