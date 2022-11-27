import 'package:ditonton/common/exception.dart';
import 'package:ditonton/core/db/database_helper.dart';
import 'package:ditonton/core/tv_series/data/models/tv_series_table.dart';

abstract class TvSeriesLocalDataSource {
  Future<String> insertTvSeriesWatchlist(TvSeriesTable tvSeries);
  Future<String> removeTvSeriesWatchlist(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSeriesById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvSeriesLocalDataSourceImpl implements TvSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvSeriesLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<String> insertTvSeriesWatchlist(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.insertTvSeriesWatchlist(tvSeries);
      return 'Added to watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvSeriesTable?> getTvSeriesById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromJson(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final results = await databaseHelper.getWatchlistTvSeries();
    return results.map((e) => TvSeriesTable.fromJson(e)).toList();
  }

  @override
  Future<String> removeTvSeriesWatchlist(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeTvSeriesWatchlist(tvSeries);
      return 'Removed from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
