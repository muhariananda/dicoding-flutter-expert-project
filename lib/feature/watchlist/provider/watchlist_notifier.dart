import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';

class WatchlistNotifier extends ChangeNotifier {
  final GetWatchlistMovies getWatchlistMovies;
  final GetWatchListTvSeries getWatchListTvSeries;

  WatchlistNotifier({
    required this.getWatchlistMovies,
    required this.getWatchListTvSeries,
  });

  var _contentSelection = ContentSelection.movie;
  ContentSelection get contentSelection => _contentSelection;

  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistMovies() async {
    _movieState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _movieState = RequestState.Loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTvSeries() async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTvSeries.execute();
    result.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _tvSeriesState = RequestState.Loaded;
        _watchlistTvSeries = data;
        notifyListeners();
      },
    );
  }

  void setSelectedContent(ContentSelection content) {
    _contentSelection = content;
    notifyListeners();
  }
}
