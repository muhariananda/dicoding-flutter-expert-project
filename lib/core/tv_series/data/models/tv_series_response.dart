import 'package:ditonton/core/tv_series/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable {
  TvSeriesResponse({
    required this.tvSeriesList,
  });

  final List<TvSeriesModel> tvSeriesList;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'results': tvSeriesList.map((x) => x.toJson()).toList(),
    };
  }

  factory TvSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TvSeriesResponse(
        tvSeriesList: List<TvSeriesModel>.from((json['results'] as List)
            .map<TvSeriesModel>((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  @override
  List<Object> get props => [tvSeriesList];
}
