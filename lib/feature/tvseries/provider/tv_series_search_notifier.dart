import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesSearchNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  TvSeriesSearchNotifier(this.searchTvSeries);

  var _searchResults = <TvSeries>[];
  List<TvSeries> get searchResults => _searchResults;

  RequestState _searchState = RequestState.Empty;
  RequestState get searchState => _searchState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _searchState = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _searchState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _searchState = RequestState.Loaded;
        _searchResults = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
