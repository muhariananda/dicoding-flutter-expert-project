import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter/foundation.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTvSeries getTopRatedTvSeries;

  TopRatedTvSeriesNotifier({
    required this.getTopRatedTvSeries,
  });

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  var _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTvSeries.execute();
    result.fold(
      (failure) {
        _topRatedTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (topRatedData) {
        _topRatedTvSeriesState = RequestState.Loaded;
        _topRatedTvSeries = topRatedData;
        notifyListeners();
      },
    );
  }
}
