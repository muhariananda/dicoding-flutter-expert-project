import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/core/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/feature/tv_series/provider/top_rated_tv_series_notifier.dart';
import 'package:ditonton/feature/tv_series_list/page/top_reated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesNotifier])
void main() {
  late MockTopRatedTvSeriesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvSeriesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvSeriesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display centered progress bar when loading",
    (WidgetTester tester) async {
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is Loaded",
    (WidgetTester tester) async {
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.topRatedTvSeries).thenReturn(<TvSeries>[]);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display centered text with message when Error",
    (WidgetTester tester) async {
      when(mockNotifier.topRatedTvSeriesState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(centerFinder, findsOneWidget);
      expect(textFinder, findsOneWidget);
    },
  );
}
