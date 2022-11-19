import 'package:ditonton/core/db/database_helper.dart';
import 'package:ditonton/core/movie/data/datasource/movie_local_data_source.dart';
import 'package:ditonton/core/movie/data/datasource/movie_remote_data_source.dart';

import 'package:ditonton/core/movie/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/core/movie/domain/repositories/movie_repository.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_detail.dart';
import 'package:ditonton/core/movie/domain/usecase/get_movie_recommendations.dart';
import 'package:ditonton/core/movie/domain/usecase/get_now_playing_movies.dart';
import 'package:ditonton/core/movie/domain/usecase/get_popular_movies.dart';
import 'package:ditonton/core/movie/domain/usecase/get_top_rated_movies.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_movies.dart';
import 'package:ditonton/core/movie/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/movie/domain/usecase/remove_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/save_watchlist.dart';
import 'package:ditonton/core/movie/domain/usecase/search_movies.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_local_data_source.dart';
import 'package:ditonton/core/tv_series/data/datasource/tv_series_remote_data_source.dart';
import 'package:ditonton/core/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:ditonton/core/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_detail_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_now_playing_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_popular_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_top_rated_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_tv_series_recommendations.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_status.dart';
import 'package:ditonton/core/tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/save_watchlist_tv_series.dart';
import 'package:ditonton/core/tv_series/domain/usecase/search_tv_series.dart';
import 'package:ditonton/feature/movie/provider/movie_detail_notifier.dart';
import 'package:ditonton/feature/movie/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/movie/provider/movie_search_notifier.dart';
import 'package:ditonton/feature/movie/provider/popular_movies_notifier.dart';
import 'package:ditonton/feature/movie/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/feature/movie/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/feature/tvseries/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/feature/tvseries/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/feature/tvseries/provider/tv_series_list_notifier.dart';
import 'package:ditonton/feature/tvseries/provider/tv_series_search_notifier.dart';
import 'package:ditonton/feature/tvseries/provider/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesListNotifier(
      getNowPlayingTvSeries: locator(),
      getPopularTvSeries: locator(),
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getDetailTvSeries: locator(),
      getTvSeriesRecommendations: locator(),
      getWatchlistStatus: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchNotifier(
      searchTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesNotifier(
      getWatchListTvSeries: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
