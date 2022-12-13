import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/page/now_playing_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'now_playing_tv_series_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvSeriesCubit])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
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
          .thenAnswer((_) => NowPayingTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

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

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockNowPlayingTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const NowPayingTvSeriesInProgress()));
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(NowPlayingTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
