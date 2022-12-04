import 'package:ditonton/feature/about/about_page.dart';
import 'package:ditonton/feature/home/page/main_page.dart';
import 'package:ditonton/feature/movie_detail/page/movie_detail_page.dart';
import 'package:ditonton/feature/movie_list/page/popular_movies_page.dart';
import 'package:ditonton/feature/movie_list/page/top_rated_movies_page.dart';
import 'package:ditonton/feature/search/page/search_page.dart';
import 'package:ditonton/feature/tv_series_list/page/now_playing_tv_series_page.dart';
import 'package:ditonton/feature/tv_series_list/page/popular_tv_series_page.dart';
import 'package:ditonton/feature/tv_series_list/page/top_reated_tv_series_page.dart';
import 'package:ditonton/feature/tv_series_detail/tv_series_detail_page.dart';
import 'package:ditonton/feature/watchlist/page/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static RouteFactory? routes() {
    return (RouteSettings settings) {
      switch (settings.name) {
        case '/home':
          return MaterialPageRoute(builder: (_) => MainPage());
        case PopularMoviesPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
        case TopRatedMoviesPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
        case MovieDetailPage.ROUTE_NAME:
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => MovieDetailPage(id: id),
            settings: settings,
          );
        case NowPlayingTvSeriesPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => NowPlayingTvSeriesPage());
        case PopularTvSeriesPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
        case TopRatedTvSeriesPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
        case TvSeriesDetailPage.ROUTE_NAME:
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => TvSeriesDetailPage(id: id),
            settings: settings,
          );
        case SearchPage.ROUTE_NAME:
          return CupertinoPageRoute(builder: (_) => SearchPage());
        case WatchlistPage.ROUTE_NAME:
          return MaterialPageRoute(builder: (_) => WatchlistPage());
        case AboutPage.ROUTE_NAME:
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
