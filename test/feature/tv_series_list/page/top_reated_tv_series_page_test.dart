import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/page/top_reated_tv_series_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'top_reated_tv_series_page_test.mocks.dart';

@GenerateMocks([TopRatedTvSeriesCubit])
void main() {
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget _makeTestableWidget(Widget body) {
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
          .thenAnswer((_) => TopRatedTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

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

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockTopRatedTvSeriesCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedTvSeriesInProgress()));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvSeriesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
