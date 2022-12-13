import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_list/cubit/now_playing_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/popular_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/cubit/top_rated_tv_series_cubit.dart';
import 'package:ditonton/feature/tv_series_list/page/tv_series_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
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

  Widget _makeTestableWidget(Widget body) {
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

  void _makeStubstream() {
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
      _makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesInProgress());
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesInProgress());
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(progressBarFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 listView when all state are Success",
    (WidgetTester tester) async {
      _makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesSuccess(testTvSeriesList));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesSuccess(testTvSeriesList));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesSuccess(testTvSeriesList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 text error messages when state are Failure",
    (WidgetTester tester) async {
      _makeStubstream();
      when(mockNowPlayingTvSeriesCubit.state)
          .thenAnswer((_) => NowPayingTvSeriesFailure('Not found'));
      when(mockPopularTvSeriesCubit.state)
          .thenAnswer((_) => PopularTvSeriesFailure('Not found'));
      when(mockTopRatedTvSeriesCubit.state)
          .thenAnswer((_) => TopRatedTvSeriesFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(TvSeriesListPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
