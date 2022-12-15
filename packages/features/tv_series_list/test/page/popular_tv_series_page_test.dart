import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTvSeriesCubit])
void main() {
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;

  setUp(() {
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvSeriesCubit>.value(
      value: mockPopularTvSeriesCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when state is InProgress",
    (WidgetTester tester) async {
      when(mockPopularTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularTvSeriesInProgress()));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => const PopularTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display listView when state is Success",
    (WidgetTester tester) async {
      when(mockPopularTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularTvSeriesInProgress()));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesSuccess(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockPopularTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularTvSeriesInProgress()));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => const PopularTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const PopularTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
