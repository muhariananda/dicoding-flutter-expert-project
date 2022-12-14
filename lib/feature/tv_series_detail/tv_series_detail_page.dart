import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/core/tv_series/domain/entities/genre.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_detail_cubit.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_recommendations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/components/components.dart';

import 'package:ditonton/core/tv_series/domain/entities/season.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series_detail.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  TvSeriesDetailCubit get _detailCubit => context.read<TvSeriesDetailCubit>();
  TvSeriesRecommendationsCubit get _recommendationCubit =>
      context.read<TvSeriesRecommendationsCubit>();

  @override
  void initState() {
    super.initState();
    _detailCubit
      ..fetchTvSeriesDetail(widget.id)
      ..loadWatchlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TvSeriesDetailCubit, TvSeriesDetailState>(
        listener: (context, state) {
          final upsertStatus = state.upsertStatus;
          if (upsertStatus != null) {
            if (upsertStatus is TvSeriesDetailUpsertSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(upsertStatus.message),
                ));
            } else if (upsertStatus is TvSeriesDetailUpsertFailure) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(upsertStatus.error),
                  );
                },
              );
            }
          }
        },
        builder: (context, state) {
          if (state.tvSeries != null) {
            final tvSeries = state.tvSeries!;
            _recommendationCubit.fetchRecommendationsTvSeries(tvSeries.id);
            return DetailContent(
              cubit: _detailCubit,
              tvSeries: tvSeries,
              isAddedWatchlist: state.watchlistStatus,
            );
          } else if (state.errorMessage != null) {
            return CenteredText(
              state.errorMessage,
              key: Key('error_detail_message'),
            );
          } else {
            return const CenteredProgressCircularIndicator();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetailCubit cubit;
  final TvSeriesDetail tvSeries;
  final bool isAddedWatchlist;

  const DetailContent(
      {Key? key,
      required this.cubit,
      required this.tvSeries,
      required this.isAddedWatchlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name ?? '-',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  cubit.addedToWatchlist(tvSeries);
                                } else {
                                  cubit.removeFromWatchlist(tvSeries);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres!),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            _SeasonList(seasons: tvSeries.seasons!),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _TvSeriesRecommendationsList(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class _SeasonList extends StatelessWidget {
  final List<Season> seasons;

  const _SeasonList({
    Key? key,
    required this.seasons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: seasons.length,
        itemBuilder: (BuildContext context, int index) {
          final season = seasons[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${season.posterPath}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  season.name!,
                  style: kSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${season.episodeCount} episodes',
                  style: kBodyText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TvSeriesRecommendationsList extends StatelessWidget {
  const _TvSeriesRecommendationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesRecommendationsCubit,
        TvSeriesRecommendationsState>(
      builder: (context, state) {
        if (state is TvSeriesRecommendationsFailure) {
          return Text(
            state.message,
            key: Key('error_recommendation_message'),
          );
        } else if (state is TvSeriesRecommendationsSuccess) {
          final recommendations = state.tvSeries;
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendations.length,
              itemBuilder: (context, index) {
                final tvSeries = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: ContentTile(
                    imageUrl: tvSeries.posterPath ?? '',
                    onTap: () {
                      Navigator.pushReplacementNamed(
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
        } else {
          return const CenteredProgressCircularIndicator();
        }
      },
    );
  }
}
