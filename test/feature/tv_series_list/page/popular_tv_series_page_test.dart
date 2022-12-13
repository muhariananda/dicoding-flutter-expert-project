import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/page/popular_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'popular_tv_series_page_test.mocks.dart';

@GenerateMocks([PopularTvSeriesCubit])
void main() {
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;

  setUp(() {
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
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
          .thenAnswer((_) => PopularTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

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

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockPopularTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularTvSeriesInProgress()));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(PopularTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
