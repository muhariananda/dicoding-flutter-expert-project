import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import '../dummy_data/dummy_movie.dart';
import '../dummy_data/dummy_tv_series.dart';
import 'search_page_test.mocks.dart';

@GenerateMocks([
  SearchMovieBloc,
  SearchTvSeriesBloc,
])
void main() {
  late MockSearchMovieBloc mockSearchMovieBloc;
  late MockSearchTvSeriesBloc mockSearchTvSeriesBloc;

  setUp(() {
    mockSearchMovieBloc = MockSearchMovieBloc();
    mockSearchTvSeriesBloc = MockSearchTvSeriesBloc();
  });

  Widget makeTestableWidgte(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchMovieBloc>.value(
          value: mockSearchMovieBloc,
        ),
        BlocProvider<SearchTvSeriesBloc>.value(
          value: mockSearchTvSeriesBloc,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display search bar",
    (WidgetTester tester) async {
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchMovieInProgress()));
      when(mockSearchMovieBloc.state)
          .thenAnswer((_) => const SearchMovieInProgress());
      when(mockSearchTvSeriesBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchTvSeriesInProgress()));
      when(mockSearchTvSeriesBloc.state)
          .thenAnswer((_) => const SearchTvSeriesInProgress());

      final searchBarFinder = find.byKey(const Key('search_bar'));

      await tester.pumpWidget(makeTestableWidgte(const SearchPage()));

      await tester.enterText(searchBarFinder, 'text');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(searchBarFinder, findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    },
  );

  testWidgets(
    "Page should display progress bar when states are InProgress",
    (WidgetTester tester) async {
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchMovieInProgress()));
      when(mockSearchMovieBloc.state)
          .thenAnswer((_) => const SearchMovieInProgress());
      when(mockSearchTvSeriesBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchTvSeriesInProgress()));
      when(mockSearchTvSeriesBloc.state)
          .thenAnswer((_) => const SearchTvSeriesInProgress());

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));
      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidgte(const SearchPage()));

      expect(movieFilterChipFinder, findsOneWidget);
      await tester.tap(movieFilterChipFinder);
      await tester.pump();
      expect(progressBarFinder, findsOneWidget);

      expect(tvSeriesFilterChipFinder, findsOneWidget);
      await tester.tap(tvSeriesFilterChipFinder);
      await tester.pump();
      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display listView when states are Success",
    (WidgetTester tester) async {
      when(mockSearchMovieBloc.stream).thenAnswer(
          (_) => Stream.value(SearchMovieSuccess(movies: testMovieList)));
      when(mockSearchMovieBloc.state)
          .thenAnswer((_) => SearchMovieSuccess(movies: testMovieList));
      when(mockSearchTvSeriesBloc.stream).thenAnswer((_) =>
          Stream.value(SearchTvSeriesSuccess(tvSeries: testTvSeriesList)));
      when(mockSearchTvSeriesBloc.state)
          .thenAnswer((_) => SearchTvSeriesSuccess(tvSeries: testTvSeriesList));

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));

      await tester.pumpWidget(makeTestableWidgte(const SearchPage()));

      expect(movieFilterChipFinder, findsOneWidget);
      await tester.tap(movieFilterChipFinder);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);

      expect(tvSeriesFilterChipFinder, findsOneWidget);
      await tester.tap(tvSeriesFilterChipFinder);
      await tester.pump();
      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    "Page should display exception indicator when states are Empty",
    (WidgetTester tester) async {
      when(mockSearchMovieBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchMovieEmpty()));
      when(mockSearchMovieBloc.state)
          .thenAnswer((_) => const SearchMovieEmpty());
      when(mockSearchTvSeriesBloc.stream)
          .thenAnswer((_) => Stream.value(const SearchTvSeriesEmpty()));
      when(mockSearchTvSeriesBloc.state)
          .thenAnswer((_) => const SearchTvSeriesEmpty());

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));
      final exceptionIndicatorFinder = find.byType(ExceptionIndicator);

      await tester.pumpWidget(makeTestableWidgte(const SearchPage()));

      expect(movieFilterChipFinder, findsOneWidget);
      await tester.tap(movieFilterChipFinder);
      await tester.pump();
      expect(exceptionIndicatorFinder, findsOneWidget);

      expect(tvSeriesFilterChipFinder, findsOneWidget);
      await tester.tap(tvSeriesFilterChipFinder);
      await tester.pump();
      expect(exceptionIndicatorFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error when states are Failure",
    (WidgetTester tester) async {
      when(mockSearchMovieBloc.stream).thenAnswer(
          (_) => Stream.value(const SearchMovieFailure(message: 'Not found')));
      when(mockSearchMovieBloc.state)
          .thenAnswer((_) => const SearchMovieFailure(message: 'Not found'));
      when(mockSearchTvSeriesBloc.stream).thenAnswer((_) =>
          Stream.value(const SearchTvSeriesFailure(message: 'Not found')));
      when(mockSearchTvSeriesBloc.state)
          .thenAnswer((_) => const SearchTvSeriesFailure(message: 'Not found'));

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));
      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidgte(const SearchPage()));

      expect(movieFilterChipFinder, findsOneWidget);
      await tester.tap(movieFilterChipFinder);
      await tester.pump();
      expect(textFinder, findsOneWidget);

      expect(tvSeriesFilterChipFinder, findsOneWidget);
      await tester.tap(tvSeriesFilterChipFinder);
      await tester.pump();
      expect(textFinder, findsOneWidget);
    },
  );
}
