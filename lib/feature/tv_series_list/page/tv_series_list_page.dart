import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_detail/tv_series_detail_page.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'now_playing_tv_series_page.dart';
import 'popular_tv_series_page.dart';
import 'top_reated_tv_series_page.dart';

class TvSeriesListPage extends StatefulWidget {
  const TvSeriesListPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  NowPlayingTvSeriesCubit get _nowPlayingCubit =>
      context.read<NowPlayingTvSeriesCubit>();
  PopularTvSeriesCubit get _popularCubit =>
      context.read<PopularTvSeriesCubit>();
  TopRatedTvSeriesCubit get _topRatedCubit =>
      context.read<TopRatedTvSeriesCubit>();

  @override
  void initState() {
    super.initState();
    _nowPlayingCubit.fetchNowPlayingTvSeries();
    _popularCubit.fetchPopularTvSeries();
    _topRatedCubit.fetchTopRatedTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                      context, NowPlayingTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
                builder: (context, state) {
                  if (state is NowPayingTvSeriesInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is NowPayingTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeriesList);
                  } else if (state is NowPayingTvSeriesFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is PopularTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeries);
                  } else if (state is PopularTvSeriesFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvSeriesInProgress) {
                    return const CenteredProgressCircularIndicator();
                  } else if (state is TopRatedTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeries);
                  } else if (state is TopRatedTvSeriesFailure) {
                    return Text(
                      state.message,
                      key: Key('error_message'),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const _TvSeriesList({
    Key? key,
    required this.tvSeriesList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tvSeriesList.length,
        itemBuilder: (BuildContext context, int index) {
          final tvSeries = tvSeriesList[index];
          return Container(
            padding: EdgeInsets.all(8.0),
            child: ContentTile(
              imageUrl: tvSeries.posterPath ?? '',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
