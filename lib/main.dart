import 'package:common/common.dart';
import 'package:component_library/component_library.dart';
import 'package:ditonton/routes.dart';
import 'package:ditonton/tab_container_page.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_ssl_pinning/http_ssl_pinning.dart';
import 'package:monitoring/monitoring.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_list/movie_list.dart';
import 'package:search/search.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_list/tv_series_list.dart';
import 'package:watchlist/watchlist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeFirebasePackage();
  await intialiazeHttpSslPinnig();
  di.init();

  // FirebaseCrashlytics.instance.crash();

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
          routeObserver,
        ],
        onGenerateRoute: Routes.routes(),
      ),
    );
  }
}
