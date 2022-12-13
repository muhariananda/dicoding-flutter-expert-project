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
import 'package:ditonton/common/http_ssl_pinning.dart';
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
import 'package:ditonton/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_recommendations_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/now_playing_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:ditonton/feature/search/bloc/search_movie_bloc.dart';
import 'package:ditonton/feature/search/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/feature/tv_series_detail/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_recommendations_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_movie_cubit.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_tv_series_cubit.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieBloc(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesDetailBloc(
      getDetailTvSeries: locator(),
      getWatchlistStatus: locator(),
      saveWatchlistTvSeries: locator(),
      removeWatchlistTvSeries: locator(),
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
