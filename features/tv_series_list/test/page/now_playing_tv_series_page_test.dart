import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
import 'now_playing_tv_series_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvSeriesCubit])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvSeriesCubit>.value(
      value: mockNowPlayingTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when state is InProgress",
    (WidgetTester tester) async {
      when(mockNowPlayingTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const NowPayingTvSeriesInProgress()));
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => const NowPayingTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display listView when state is Success",
    (WidgetTester tester) async {
      when(mockNowPlayingTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const NowPayingTvSeriesInProgress()));
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesSuccess(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockNowPlayingTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const NowPayingTvSeriesInProgress()));
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => const NowPayingTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester
          .pumpWidget(makeTestableWidget(const NowPlayingTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
