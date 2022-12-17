import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
import 'top_reated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesCubit])
void main() {
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvSeriesCubit>.value(
      value: mockTopRatedTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when state is InProgress",
    (WidgetTester tester) async {
      when(mockTopRatedTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedTvSeriesInProgress()));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => const TopRatedTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display listView when state is Success",
    (WidgetTester tester) async {
      when(mockTopRatedTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedTvSeriesInProgress()));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesSuccess(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockTopRatedTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedTvSeriesInProgress()));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => const TopRatedTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
