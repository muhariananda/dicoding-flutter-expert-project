import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/centered_progress_circular_indicator.dart';
import 'package:ditonton/feature/watchlist/provider/watchlist_notifier.dart';
import 'package:ditonton/feature/watchlist/page/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistNotifier])
void main() {
  late MockWatchlistNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group("Movie watchlist,", () {
    testWidgets(
      "Page should display progress bar when the data is Loading",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.movie);
        when(mockNotifier.movieState).thenReturn(RequestState.Loading);

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when the data is loaded",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.movie);
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.watchlistMovies).thenReturn(testMovieList);

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final listViewFinder = find.byKey(Key('movie_listview'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display text with message when error",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.movie);
        when(mockNotifier.movieState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Cannot get data');

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(textFinder, findsOneWidget);
      },
    );
  });

  group("Tv series watchlist", () {
    testWidgets(
      "Page should display progress bar when the data is Loading",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.tv);
        when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when the data is Loaded",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.tv);
        when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
        when(mockNotifier.watchlistTvSeries).thenReturn(testTvSeriesList);

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final listViewFinder = find.byKey(Key('tv_series_listview'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display text with message when error",
      (WidgetTester tester) async {
        when(mockNotifier.contentSelection).thenReturn(ContentSelection.tv);
        when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Cannot get data');

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

        await tester.tap(filterChipFinder);

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
