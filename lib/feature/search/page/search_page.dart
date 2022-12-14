import 'package:ditonton/common/tag.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/search/bloc/search_movie_bloc.dart';
import 'package:ditonton/feature/search/bloc/search_tv_series_bloc.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchBarController = TextEditingController();

  SearchMovieBloc get _searchMovieBloc => context.read<SearchMovieBloc>();
  SearchTvSeriesBloc get _searchTvSeriesBloc =>
      context.read<SearchTvSeriesBloc>();

  Tag _tag = Tag.movie;

  @override
  void initState() {
    super.initState();
    _searchBarController.addListener(() {
      _searchMovieBloc.add(
        SearchMovieOnQueryChanged(query: _searchBarController.text),
      );
      _searchTvSeriesBloc.add(
        SearchTvSeriesOnQueryChanged(query: _searchBarController.text),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: Key('search_bar'),
              controller: _searchBarController,
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  key: Key('movie_filter_chip'),
                  label: Text('Movies'),
                  selected: _tag == Tag.movie,
                  onSelected: (_) {
                    setState(() {
                      _tag = Tag.movie;
                    });
                  },
                ),
                FilterChip(
                  key: Key('tv_series_filter_chip'),
                  label: Text('Tv Series'),
                  selected: _tag == Tag.tv,
                  onSelected: (_) {
                    setState(() {
                      _tag = Tag.tv;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: (_tag == Tag.movie)
                  ? _MovieSearchList()
                  : _TvSeriesSearchList(),
            )
          ],
        ),
      ),
    );
  }
}

class _MovieSearchList extends StatelessWidget {
  const _MovieSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      builder: (context, state) {
        if (state is SearchMovieSuccess) {
          return VerticaledMovieList(movies: state.movies);
        } else if (state is SearchMovieEmpty) {
          return const ExceptionIndicator();
        } else if (state is SearchMovieFailure) {
          return CenteredText(state.message);
        } else {
          return const CenteredProgressCircularIndicator();
        }
      },
    );
  }
}

class _TvSeriesSearchList extends StatelessWidget {
  const _TvSeriesSearchList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
      builder: (context, state) {
        if (state is SearchTvSeriesSuccess) {
          return VerticaledTvSeriesList(tvSeriesList: state.tvSeries);
        } else if (state is SearchTvSeriesEmpty) {
          return const ExceptionIndicator();
        } else if (state is SearchTvSeriesFailure) {
          return CenteredText(state.message);
        } else {
          return const CenteredProgressCircularIndicator();
        }
      },
    );
  }
}
