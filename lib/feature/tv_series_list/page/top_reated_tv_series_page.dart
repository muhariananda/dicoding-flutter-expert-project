import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  State<TopRatedTvSeriesPage> createState() => _TopRatedTvSeriesPageState();
}

class _TopRatedTvSeriesPageState extends State<TopRatedTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
          builder: (context, state) {
            if (state is TopRatedTvSeriesInProgress) {
              return const CenteredProgressCircularIndicator();
            } else if (state is TopRatedTvSeriesSuccess) {
              return VerticaledTvSeriesList(tvSeriesList: state.tvSeries);
            } else if (state is TopRatedTvSeriesFailure) {
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
