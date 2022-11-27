import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/centered_progress_circular_indicator.dart';
import 'package:ditonton/feature/home/page/home_tv_series_page.dart';
import 'package:ditonton/feature/home/provider/tv_series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_home_page_test.mocks.dart';

@GenerateMocks([TvSeriesListNotifier])
void main() {
  late MockTvSeriesListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSeriesListNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSeriesListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display all progress bars when data is Loading",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularState).thenReturn(RequestState.Loading);
      when(mockNotifier.topRatedState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage()));

      expect(progressBarFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display all listview when data is Loaded",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
      when(mockNotifier.nowPlayingTvSeries).thenReturn(testTvSeriesList);
      when(mockNotifier.popularState).thenReturn(RequestState.Loaded);
      when(mockNotifier.popularTvSeries).thenReturn(testTvSeriesList);
      when(mockNotifier.topRatedState).thenReturn(RequestState.Loaded);
      when(mockNotifier.topRatedTvSeries).thenReturn(testTvSeriesList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display text with message when error",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockNotifier.popularState).thenReturn(RequestState.Error);
      when(mockNotifier.topRatedState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Failed');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(HomeTvSeriesPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
