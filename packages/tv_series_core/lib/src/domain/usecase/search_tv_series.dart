import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import '../entities/entittes.dart';
import '../repositories/tv_series_repository.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeriess(query);
  }
}
