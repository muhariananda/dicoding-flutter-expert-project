import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_core/tv_series_core.dart';

import '../cubit/now_playing_tv_series_cubit.dart';
import '../cubit/popular_tv_series_cubit.dart';
import '../cubit/top_rated_tv_series_cubit.dart';
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
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SubHeading(
                title: 'Now Playing',
                onTap: () {
                  Navigator.pushNamed(
                      context, NowPlayingTvSeriesPage.routeName);
                },
              ),
              BlocBuilder<NowPlayingTvSeriesCubit, NowPlayingTvSeriesState>(
                builder: (context, state) {
                  if (state is NowPayingTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeriesList);
                  } else if (state is NowPayingTvSeriesFailure) {
                    return Text(state.message);
                  } else {
                    return const CenteredProgressCircularIndicator();
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.routeName);
                },
              ),
              BlocBuilder<PopularTvSeriesCubit, PopularTvSeriesState>(
                builder: (context, state) {
                  if (state is PopularTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeries);
                  } else if (state is PopularTvSeriesFailure) {
                    return Text(
                      state.message,
                    );
                  } else {
                    return const CenteredProgressCircularIndicator();
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.routeName);
                },
              ),
              BlocBuilder<TopRatedTvSeriesCubit, TopRatedTvSeriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvSeriesSuccess) {
                    return _TvSeriesList(tvSeriesList: state.tvSeries);
                  } else if (state is TopRatedTvSeriesFailure) {
                    return Text(state.message);
                  } else {
                    return const CenteredProgressCircularIndicator();
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
            padding: const EdgeInsets.all(8.0),
            child: ContentTile(
              imageUrl: tvSeries.posterPath ?? '',
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.routeName,
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
