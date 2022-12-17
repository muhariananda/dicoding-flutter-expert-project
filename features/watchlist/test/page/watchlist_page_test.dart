import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';

import '../dummy_data/dummy_movie.dart';
import '../dummy_data/dummy_tv_series.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([
  WatchlistMovieCubit,
  WatchlistTvSeriesCubit,
])
void main() {
  late MockWatchlistMovieCubit mockWatchlistMovieCubit;
  late MockWatchlistTvSeriesCubit mockWatchlistTvSeriesCubit;

  setUp(() {
    mockWatchlistMovieCubit = MockWatchlistMovieCubit();
    mockWatchlistTvSeriesCubit = MockWatchlistTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieCubit>.value(
          value: mockWatchlistMovieCubit,
        ),
        BlocProvider<WatchlistTvSeriesCubit>.value(
          value: mockWatchlistTvSeriesCubit,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when states are InProgress",
    (WidgetTester tester) async {
      when(mockWatchlistMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistMovieInProgress()));
      when(mockWatchlistTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const WatchlistTvSeriesInProgress()));
      when(mockWatchlistMovieCubit.state)
          .thenAnswer((_) => const WatchlistMovieInProgress());
      when(mockWatchlistTvSeriesCubit.state)
          .thenAnswer((_) => const WatchlistTvSeriesInProgress());

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));
      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

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
    "Page should display listview when states are Success",
    (WidgetTester tester) async {
      when(mockWatchlistMovieCubit.stream).thenAnswer(
          (_) => Stream.value(WatchlistMovieSuccess(movies: testMovieList)));
      when(mockWatchlistTvSeriesCubit.stream).thenAnswer((_) =>
          Stream.value(WatchlistTvSeriesSuccess(tvSeries: testTvSeriesList)));
      when(mockWatchlistMovieCubit.state)
          .thenAnswer((_) => WatchlistMovieSuccess(movies: testMovieList));
      when(mockWatchlistTvSeriesCubit.state).thenAnswer(
          (_) => WatchlistTvSeriesSuccess(tvSeries: testTvSeriesList));

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));

      await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

      expect(movieFilterChipFinder, findsOneWidget);
      await tester.tap(movieFilterChipFinder);
      await tester.pump();
      expect(find.byKey(const Key('movie_list_view')), findsOneWidget);

      expect(tvSeriesFilterChipFinder, findsOneWidget);
      await tester.tap(tvSeriesFilterChipFinder);
      await tester.pump();
      expect(find.byKey(const Key('tv_series_list_view')), findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when states are Failure",
    (WidgetTester tester) async {
      when(mockWatchlistMovieCubit.stream).thenAnswer((_) => Stream.value(
          const WatchlistMovieFailure(message: 'Cannot get data')));
      when(mockWatchlistTvSeriesCubit.stream).thenAnswer((_) => Stream.value(
          const WatchlistTvSeriesFailure(message: 'Cannot get data')));
      when(mockWatchlistMovieCubit.state).thenAnswer(
          (_) => const WatchlistMovieFailure(message: 'Cannot get data'));
      when(mockWatchlistTvSeriesCubit.state).thenAnswer(
          (_) => const WatchlistTvSeriesFailure(message: 'Cannot get data'));

      final movieFilterChipFinder = find.byKey(const Key('movie_filter_chip'));
      final tvSeriesFilterChipFinder =
          find.byKey(const Key('tv_series_filter_chip'));
      final textFinder = find.text('Cannot get data');

      await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

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
