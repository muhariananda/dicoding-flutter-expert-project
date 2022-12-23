import 'package:db_sqflite/db_sqflite.dart';
import 'package:get_it/get_it.dart';
import 'package:http_ssl_pinning/http_ssl_pinning.dart';
import 'package:movie_core/movie_core.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_list/movie_list.dart';
import 'package:search/search.dart';
import 'package:tv_series_core/tv_series_core.dart';
import 'package:tv_series_detail/tv_series_detail.dart';

import 'package:tv_series_list/tv_series_list.dart';

import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchTvSeriesBloc(
      searchTvSeries: locator(),
    ),
  );

  //cubit
  locator.registerFactory(
    () => NowPlayingMovieCubit(
      getNowPlayingMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieCubit(
      getPopularMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieCubit(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieRecommendationsCubit(
      getMovieRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieCubit(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailCubit(
      getMovieDetail: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => NowPlayingTvSeriesCubit(
      getNowPlayingTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvSeriesCubit(
      getPopularTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvSeriesCubit(
      getTopRatedTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesRecommendationsCubit(
      getTvSeriesRecommendations: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvSeriesCubit(
      getWatchListTvSeries: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailCubit(
      getDetailTvSeries: locator(),
      getWatchlistStatus: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
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
    () => MovieRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<MovieLocalDataSource>(
    () => MovieLocalDataSourceImpl(databaseHelper: locator()),
  );

  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
    () => TvSeriesRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
    () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper(),
  );

  // external
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
