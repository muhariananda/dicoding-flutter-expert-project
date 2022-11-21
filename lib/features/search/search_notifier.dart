import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/core/movie/domain/usecase/search_movies.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';

enum SearchContent { Movie, Tv }

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvSeries searchTvSeries;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvSeries,
  });

  SearchContent _searchContent = SearchContent.Movie;
  SearchContent get searchContent => _searchContent;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  var _movieSearchResult = <Movie>[];
  List<Movie> get movieSearchResult => _movieSearchResult;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  var _tvSeriesSearchResult = <TvSeries>[];
  List<TvSeries> get tvSeriesSearchResult => _tvSeriesSearchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _movieState = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _movieState = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _movieSearchResult = data;
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTvSeriesSearch(String query) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _tvSeriesState = RequestState.Loaded;
        _tvSeriesSearchResult = data;
        notifyListeners();
      },
    );
  }

  void updateSearchContent(SearchContent content) {
    _searchContent = content;
    notifyListeners();
  }
}
