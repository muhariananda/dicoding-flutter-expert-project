import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series/page/tv_series_detail_page.dart';
import 'package:ditonton/feature/tv_series/page/popular_tv_series_page.dart';
import 'package:ditonton/feature/tv_series/page/top_reated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/feature/home/provider/tv_series_list_notifier.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<TvSeriesListNotifier>()
        ..fetchNowPlayingTvSeries()
        ..fetchPopularTvSeries()
        ..fetchTopRatedTvSeries(),
    );
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
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, value, child) {
                  final state = value.nowPlayingState;
                  if (state == RequestState.Loading) {
                    return CenteredProgressCircularIndicator();
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(tvSeriesList: value.nowPlayingTvSeries);
                  } else {
                    return const Text(
                      'Failed',
                      key: Key('error_message'),
                    );
                  }
                },
              ),
              SubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, value, child) {
                  final state = value.popularState;
                  if (state == RequestState.Loading) {
                    return CenteredProgressCircularIndicator();
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(tvSeriesList: value.popularTvSeries);
                  } else {
                    return const Text(
                      'Failed',
                      key: Key('error_message'),
                    );
                  }
                },
              ),
              SubHeading(
                title: 'Top Rated',
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME);
                },
              ),
              Consumer<TvSeriesListNotifier>(
                builder: (context, value, child) {
                  final state = value.topRatedState;
                  if (state == RequestState.Loading) {
                    return CenteredProgressCircularIndicator();
                  } else if (state == RequestState.Loaded) {
                    return TvSeriesList(tvSeriesList: value.topRatedTvSeries);
                  } else {
                    return const Text(
                      'Failed',
                      key: Key('error_message'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesList({
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
            padding: EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeries.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}