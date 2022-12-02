import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/feature/tv_series/provider/now_playing_tv_series_notifier.dart';
import 'package:ditonton/feature/tv_series/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/feature/home/page/main_page.dart';
import 'package:ditonton/feature/home/provider/tv_series_list_notifier.dart';
import 'package:ditonton/feature/tv_series/provider/popular_tv_series_notifier.dart';
import 'package:ditonton/feature/tv_series/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/feature/movie/provider/movie_detail_notifier.dart';
import 'package:ditonton/feature/home/provider/movie_list_notifier.dart';
import 'package:ditonton/feature/search/provider/search_notifier.dart';
import 'package:ditonton/feature/movie/provider/popular_movies_notifier.dart';
import 'package:ditonton/feature/movie/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/feature/watchlist/provider/watchlist_notifier.dart';
import 'package:ditonton/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

import 'common/secure_http_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpSslPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NowPlayingTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
        ),
        home: MainPage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: Routes.routes(),
      ),
    );
  }
}
