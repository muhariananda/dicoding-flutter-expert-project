import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/detail_tv_series/tv_series_detail_notifier.dart';
import 'package:ditonton/features/detail_tv_series/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/tv_series/dummy_tv_series.dart';
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
    "Watchlist button should display SnackBar when added to wathclist",
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
}
