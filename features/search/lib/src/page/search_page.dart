import 'package:common/common.dart';
import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_movie_bloc.dart';
import '../bloc/search_tv_series_bloc.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

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
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('search_bar'),
              controller: _searchBarController,
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Wrap(
              spacing: 10,
              children: [
                FilterChip(
                  key: const Key('movie_filter_chip'),
                  label: const Text('Movies'),
                  selected: _tag == Tag.movie,
                  onSelected: (_) {
                    setState(() {
                      _tag = Tag.movie;
                    });
                  },
                ),
                FilterChip(
                  key: const Key('tv_series_filter_chip'),
                  label: const Text('Tv Series'),
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
                  ? const _MovieSearchList()
                  : const _TvSeriesSearchList(),
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
        if (state is SearchMovieInProgress) {
          return const CenteredProgressCircularIndicator();
        } else if (state is SearchMovieSuccess) {
          return VerticaledMovieList(movies: state.movies);
        } else if (state is SearchMovieEmpty) {
          return const ExceptionIndicator();
        } else if (state is SearchMovieFailure) {
          return CenteredText(state.message);
        } else {
          return Container();
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
        if (state is SearchTvSeriesInProgress) {
          return const CenteredProgressCircularIndicator();
        } else if (state is SearchTvSeriesSuccess) {
          return VerticaledTvSeriesList(tvSeriesList: state.tvSeries);
        } else if (state is SearchTvSeriesEmpty) {
          return const ExceptionIndicator();
        } else if (state is SearchTvSeriesFailure) {
          return CenteredText(state.message);
        } else {
          return Container();
        }
      },
    );
  }
}
