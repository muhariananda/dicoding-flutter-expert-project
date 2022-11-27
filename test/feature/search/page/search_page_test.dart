import 'package:ditonton/common/content_selection.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/search/provider/search_notifier.dart';
import 'package:ditonton/feature/search/page/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([SearchNotifier])
void main() {
  late MockSearchNotifier mockNotifer;

  setUp(() {
    mockNotifer = MockSearchNotifier();
  });

  Widget _makeTestableWidgte(Widget body) {
    return ChangeNotifierProvider<SearchNotifier>.value(
      value: mockNotifer,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display search bar",
    (WidgetTester tester) async {
      when(mockNotifer.selectedContent).thenReturn(ContentSelection.movie);
      when(mockNotifer.movieState).thenReturn(RequestState.Loading);

      final searchBarFinder = find.byKey(Key('search_bar'));

      await tester.pumpWidget(_makeTestableWidgte(SearchPage()));
      await tester.enterText(searchBarFinder, 'text');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(searchBarFinder, findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    },
  );

  group("Search Movie,", () {
    testWidgets(
      "Page should display Circular Progress when the data is Loading",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.movie);
        when(mockNotifer.movieState).thenReturn(RequestState.Loading);

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when the data is Loaded",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.movie);
        when(mockNotifer.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifer.movieSearchResult).thenReturn(testMovieList);

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final listViewFinder = find.byKey(Key('movie_listview'));

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display text with message when Error",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.movie);
        when(mockNotifer.movieState).thenReturn(RequestState.Error);
        when(mockNotifer.message).thenReturn('Error message');

        final filterChipFinder = find.byKey(Key('movie_filter_chip'));
        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(textFinder, findsOneWidget);
      },
    );
  });

  group("Search tv series,", () {
    testWidgets(
      "Page should display Circular Progress when the data is Loading",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.tv);
        when(mockNotifer.tvSeriesState).thenReturn(RequestState.Loading);

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when the data is Loaded",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.tv);
        when(mockNotifer.tvSeriesState).thenReturn(RequestState.Loaded);
        when(mockNotifer.tvSeriesSearchResult).thenReturn(testTvSeriesList);

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final listViewFinder = find.byKey(Key('tv_series_listview'));

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display text with message when Error",
      (WidgetTester tester) async {
        when(mockNotifer.selectedContent).thenReturn(ContentSelection.tv);
        when(mockNotifer.tvSeriesState).thenReturn(RequestState.Error);
        when(mockNotifer.message).thenReturn('Error message');

        final filterChipFinder = find.byKey(Key('tv_series_filter_chip'));
        final textFinder = find.byKey(Key('error_message'));

        await tester.pumpWidget(_makeTestableWidgte(SearchPage()));

        await tester.tap(filterChipFinder);
        await tester.pump();

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
