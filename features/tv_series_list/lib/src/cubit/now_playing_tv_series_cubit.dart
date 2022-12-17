import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series_domain/tv_series_domain.dart';

part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesCubit extends Cubit<NowPlayingTvSeriesState> {
  final GetNowPlayingTvSeries getNowPlayingTvSeries;

  NowPlayingTvSeriesCubit({
    required this.getNowPlayingTvSeries,
  }) : super(const NowPayingTvSeriesInProgress());

  Future<void> fetchNowPlayingTvSeries() async {
    final result = await getNowPlayingTvSeries.execute();
    result.fold(
      (failure) {
        emit(
          NowPayingTvSeriesFailure(failure.message),
        );
      },
      (data) {
        emit(
          NowPayingTvSeriesSuccess(data),
        );
      },
    );
  }
}
