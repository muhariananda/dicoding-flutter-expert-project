import 'package:about/about.dart';
import 'package:ditonton/tab_container_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_detail/movie_detail.dart';
import 'package:movie_list/movie_list.dart';
import 'package:search/search.dart';
import 'package:tv_series_detail/tv_series_detail.dart';
import 'package:tv_series_list/tv_series_list.dart';
import 'package:watchlist/watchlist.dart';

class Routes {
  static RouteFactory? routes() {
    return (RouteSettings settings) {
      switch (settings.name) {
        case '/home':
          return MaterialPageRoute(builder: (_) => TabContainerPage());
        case PopularMoviesPage.routeName:
          return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
        case TopRatedMoviesPage.routeName:
          return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
        case MovieDetailPage.routeName:
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => MovieDetailPage(id: id),
            settings: settings,
          );
        case NowPlayingTvSeriesPage.routeName:
          return CupertinoPageRoute(builder: (_) => NowPlayingTvSeriesPage());
        case PopularTvSeriesPage.routeName:
          return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
        case TopRatedTvSeriesPage.routeName:
          return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
        case TvSeriesDetailPage.routeName:
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => TvSeriesDetailPage(id: id),
            settings: settings,
          );
        case SearchPage.routeName:
          return CupertinoPageRoute(builder: (_) => SearchPage());
        case WatchlistPage.routeName:
          return MaterialPageRoute(builder: (_) => WatchlistPage());
        case AboutPage.routeName:
          return MaterialPageRoute(builder: (_) => AboutPage());
        default:
          return MaterialPageRoute(
            builder: (_) {
              return Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            },
          );
      }
    };
  }
}
