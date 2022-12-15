import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series_list/tv_series_list.dart';

import '../dummy_tv_series.dart';
import 'tv_series_list_page_test.mocks.dart';

@GenerateMocks([
  NowPlayingTvSeriesCubit,
  PopularTvSeriesCubit,
  TopRatedTvSeriesCubit,
])
void main() {
  late MockNowPlayingTvSeriesCubit mockNowPlayingTvSeriesCubit;
  late MockPopularTvSeriesCubit mockPopularTvSeriesCubit;
  late MockTopRatedTvSeriesCubit mockTopRatedTvSeriesCubit;

  setUp(() {
    mockNowPlayingTvSeriesCubit = MockNowPlayingTvSeriesCubit();
    mockPopularTvSeriesCubit = MockPopularTvSeriesCubit();
    mockTopRatedTvSeriesCubit = MockTopRatedTvSeriesCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvSeriesCubit>.value(
          value: mockNowPlayingTvSeriesCubit,
        ),
        BlocProvider<PopularTvSeriesCubit>.value(
          value: mockPopularTvSeriesCubit,
        ),
        BlocProvider<TopRatedTvSeriesCubit>.value(
          value: mockTopRatedTvSeriesCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  void makeStubstream() {
    when(mockNowPlayingTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(const NowPayingTvSeriesInProgress()));
    when(mockPopularTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(const PopularTvSeriesInProgress()));
    when(mockTopRatedTvSeriesCubit.stream)
        .thenAnswer((_) => Stream.value(const TopRatedTvSeriesInProgress()));
  }

  testWidgets(
    "Page should display 3 centered progress bars when all state are InProgress",
    (WidgetTester tester) async {
      makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => const NowPayingTvSeriesInProgress());
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => const PopularTvSeriesInProgress());
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => const TopRatedTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const TvSeriesListPage()));

      expect(progressBarFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 listView when all state are Success",
    (WidgetTester tester) async {
      makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesSuccess(testTvSeriesList));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesSuccess(testTvSeriesList));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesSuccess(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TvSeriesListPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 text error messages when state are Failure",
    (WidgetTester tester) async {
      makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => const NowPayingTvSeriesFailure('Not found'));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => const PopularTvSeriesFailure('Not found'));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => const TopRatedTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const TvSeriesListPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
