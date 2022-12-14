import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/core/movie/domain/entities/genre.dart';
import 'package:ditonton/core/movie/domain/entities/movie_detail.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_recommendations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieDetailCubit get _detailCubit => context.read<MovieDetailCubit>();
  MovieRecommendationsCubit get _recommendationsCubit =>
      context.read<MovieRecommendationsCubit>();

  @override
  void initState() {
    super.initState();
    _detailCubit
      ..fetchMovieDetail(widget.id)
      ..loadWatchlistStatus(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<MovieDetailCubit, MovieDetailState>(
        listener: (context, state) {
          final upsertStatus = state.upsertStatus;
          if (upsertStatus != null) {
            if (upsertStatus is MovieDetailUpsertSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(upsertStatus.message)),
                );
            } else if (upsertStatus is MovieDetailUpsertFailure) {
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
          if (state.movie != null) {
            final movie = state.movie!;
            _recommendationsCubit.fetchMovieRecommendations(movie.id);
            return DetailContent(
              movie: movie,
              isAddedToWatchlist: state.watchlistStatus,
              cubit: _detailCubit,
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
  final MovieDetail movie;
  final bool isAddedToWatchlist;
  final MovieDetailCubit cubit;

  const DetailContent({
    Key? key,
    required this.movie,
    required this.isAddedToWatchlist,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedToWatchlist) {
                                  cubit.addedToWatchlist(movie);
                                } else {
                                  cubit.removeFromWatchlist(movie);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  cubit.state.watchlistStatus
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _MovieRecommendationsList(),
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class _MovieRecommendationsList extends StatelessWidget {
  const _MovieRecommendationsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRecommendationsCubit, MovieRecommendationsState>(
      builder: (context, state) {
        if (state is MovieRecommendationsFailure) {
          return Text(
            state.message,
            key: Key('error_recommendation_message'),
          );
        } else if (state is MovieRecommendationsSuccess) {
          final movies = state.movies;
          return SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ContentTile(
                    imageUrl: movie.posterPath ?? '',
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
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
