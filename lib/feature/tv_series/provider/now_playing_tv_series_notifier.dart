import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:flutter/cupertino.dart';

import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';

class NowPlayingTvSeriesNotifier extends ChangeNotifier {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesNotifier({
    required this.getNowPlayingTvSeries,
  });

  var _nowPlayingTvSeries = <TvSeries>[];
  List<TvSeries> get nowPlayingTvSeries => _nowPlayingTvSeries;

  var _state = RequestState.Empty;
  RequestState get state => _state;

  var _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _nowPlayingTvSeries = data;
        notifyListeners();
      },
    );
  }
}
