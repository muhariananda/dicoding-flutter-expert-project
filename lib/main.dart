import 'package:ditonton/common/constants.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_detail_cubit.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_recommendations_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:ditonton/feature/search/bloc/search_movie_bloc.dart';
import 'package:ditonton/feature/search/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_detail_cubit.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_recommendations_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_movie_cubit.dart';
import 'package:ditonton/feature/watchlist/cubit/watchlist_tv_series_cubit.dart';
import 'package:ditonton/monitoring/analytics_service.dart';
import 'package:ditonton/routes.dart';
import 'package:ditonton/screen_view_observer.dart';
import 'package:ditonton/tab_container_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/http_ssl_pinning.dart';
import 'feature/movie_list/cubit/now_playing_movie_cubit.dart';
import 'monitoring/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseCrashlytics.instance.crash();

  HttpSslPinning.init();
  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvSeriesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesDetailCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSeriesRecommendationsCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
        ),
        home: TabContainerPage(),
        navigatorObservers: [
          ScreenViewObserver(
            analyticsSerivce: AnalyticsSerivce(),
          ),
        ],
        onGenerateRoute: Routes.routes(),
      ),
    );
  }
}
