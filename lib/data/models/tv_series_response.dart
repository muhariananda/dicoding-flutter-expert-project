import 'package:equatable/equatable.dart';

import 'package:ditonton/data/models/tv_series_model.dart';

class TvSeriesResponse extends Equatable {
  TvSeriesResponse({
    required this.tvSeriesList,
  });

  final List<TvSeriesModel> tvSeriesList;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tvSeriesList': tvSeriesList.map((x) => x.toJson()).toList(),
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
