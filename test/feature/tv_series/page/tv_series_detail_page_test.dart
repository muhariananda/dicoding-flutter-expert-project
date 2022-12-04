import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series/provider/tv_series_detail_notifier.dart';
import 'package:ditonton/feature/tv_series_detail/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([TvSeriesDetailNotifier])
void main() {
  late MockTvSeriesDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tId = 1;

  testWidgets(
    "Page should display progress bar when the data is Loading",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display content when the data is Loaded",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final contentFinder = find.byType(DetailContent);
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(contentFinder, findsOneWidget);
      expect(listViewFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    "Page should display text with message when error",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(find.text('Error message'), findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv series not added to watchlist",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display check icon when tv series is adedd to watchlist",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display SnackBar with added message when added to wathclist",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display SnackBar with removed message when added to wathclist",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);
      when(mockNotifier.watchlistMessage).thenReturn('Removed from watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display AlertDialog when add to watchlist is failed",
    (WidgetTester tester) async {
      when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
      when(mockNotifier.recommendationsState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvSeriesRecommendations).thenReturn(testTvSeriesList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );

  group("Recomendations", () {
    testWidgets(
      "Page should display progress bar when the data is Loading",
      (WidgetTester tester) async {
        when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
        when(mockNotifier.recommendationsState)
            .thenReturn(RequestState.Loading);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester
            .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error with message when error",
      (WidgetTester tester) async {
        when(mockNotifier.tvSeriesState).thenReturn(RequestState.Loaded);
        when(mockNotifier.tvSeries).thenReturn(testTvSeriesDetail);
        when(mockNotifier.recommendationsState).thenReturn(RequestState.Error);
        when(mockNotifier.message).thenReturn('Error message');
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final textFinder = find.byType(CenteredText);

        await tester
            .pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: tId)));

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
