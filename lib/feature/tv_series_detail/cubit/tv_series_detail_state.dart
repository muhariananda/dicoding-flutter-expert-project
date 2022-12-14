part of 'tv_series_detail_cubit.dart';

class TvSeriesDetailState extends Equatable {
  final TvSeriesDetail? tvSeries;
  final dynamic errorMessage;
  final bool watchlistStatus;
  final TvSeriesDetailUpsertStatus? upsertStatus;

  const TvSeriesDetailState({
    this.tvSeries,
    this.errorMessage,
    this.watchlistStatus = false,
    this.upsertStatus,
  });

  TvSeriesDetailState copyWith({
    TvSeriesDetail? tvSeries,
    dynamic errorMessage,
    bool? watchlistStatus,
    TvSeriesDetailUpsertStatus? upsertStatus,
  }) {
    return TvSeriesDetailState(
      tvSeries: tvSeries ?? this.tvSeries,
      errorMessage: errorMessage ?? this.errorMessage,
      watchlistStatus: watchlistStatus ?? this.watchlistStatus,
      upsertStatus: upsertStatus ?? this.upsertStatus,
    );
  }

  @override
  List<Object?> get props => [
        tvSeries,
        errorMessage,
        watchlistStatus,
        upsertStatus,
      ];
}

abstract class TvSeriesDetailUpsertStatus extends Equatable {
  const TvSeriesDetailUpsertStatus();
}

class TvSeriesDetailUpsertSuccess extends TvSeriesDetailUpsertStatus {
  final String message;

  TvSeriesDetailUpsertSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class TvSeriesDetailUpsertFailure extends TvSeriesDetailUpsertStatus {
  final String error;

  TvSeriesDetailUpsertFailure(this.error);

  @override
  List<Object?> get props => [error];
}
