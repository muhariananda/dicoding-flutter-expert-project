import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  final GetWatchListTvSeries getWatchListTvSeries;

  WatchlistTvSeriesNotifier({
    required this.getWatchListTvSeries,
  });

  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistData) {
        _watchlistState = RequestState.Loaded;
        _watchlistTvSeries = watchlistData;
        notifyListeners();
      },
    );
  }
}
