import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/core/movie/domain/entities/movie.dart';
import 'package:ditonton/feature/movie_detail/page/movie_detail_page.dart';
import 'package:ditonton/feature/movie/provider/movie_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailNotifier])
void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display centered progress bar when the data is Loading",
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display detail content when the data was Loaded",
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
      when(mockNotifier.movie).thenReturn(testMovieDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final contentFinder = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(contentFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text with message when error",
    (WidgetTester tester) async {
      when(mockNotifier.movieState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.text('Error message');

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar with added message when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar with removed message when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  group("Movie recommendations", () {
    testWidgets(
      "should display centered progress bar when data is Loading",
      (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loading);

        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display ListView when data was Loaded",
      (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movieRecommendations).thenReturn(testMovieList);

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display text with message when error",
      (WidgetTester tester) async {
        when(mockNotifier.movieState).thenReturn(RequestState.Loaded);
        when(mockNotifier.movie).thenReturn(testMovieDetail);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.recommendationState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error message');

        final textFinder = find.text('Error message');

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
