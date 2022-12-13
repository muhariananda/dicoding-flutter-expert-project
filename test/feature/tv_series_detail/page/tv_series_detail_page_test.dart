import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/tv_series_detail/bloc/tv_series_detail_bloc.dart';
import 'package:ditonton/feature/tv_series_detail/cubit/tv_series_recommendations_cubit.dart';
import 'package:ditonton/feature/tv_series_detail/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/tv_series/dummy_tv_series.dart';
import 'tv_series_detail_page_test.mocks.dart';

@GenerateMocks([
  TvSeriesDetailBloc,
  TvSeriesRecommendationsCubit,
])
void main() {
  late MockTvSeriesDetailBloc mockTvSeriesDetailBloc;
  late MockTvSeriesRecommendationsCubit mockTvSeriesRecommendationsCubit;

  setUp(() {
    mockTvSeriesDetailBloc = MockTvSeriesDetailBloc();
    mockTvSeriesRecommendationsCubit = MockTvSeriesRecommendationsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>.value(
          value: mockTvSeriesDetailBloc,
        ),
        BlocProvider<TvSeriesRecommendationsCubit>.value(
          value: mockTvSeriesRecommendationsCubit,
        )
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display progress bar when states of tv series is null",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailState()),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(),
      );

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display detail content and 2 listView when state of tv series not null",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailState()),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(tvSeries: testTvSeriesDetail),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final contentFinder = find.byType(DetailContent);
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(contentFinder, findsOneWidget);
      expect(listViewFinder, findsNWidgets(2));
    },
  );

  testWidgets(
    "Page should display text with message when state of error is not null",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailState()),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(errorMessage: 'Not found'),
      );

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.text('Not found'), findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display add icon when tv series not added to watchlist",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailState()),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          watchlistStatus: false,
        ),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Watchlist button should display check icon when tv series is adedd to watchlist",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesDetailState()),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          watchlistStatus: true,
        ),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display SnackBar with message when upsertStatus is Success to added",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(
          TvSeriesDetailState(
            tvSeries: testTvSeriesDetail,
            watchlistStatus: false,
            upsertStatus: TvSeriesDetailUpsertSuccess('Added to Watchlist'),
          ),
        ),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          watchlistStatus: false,
          upsertStatus: TvSeriesDetailUpsertSuccess('Added to Watchlist'),
        ),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    "Page should display SnackBar with message when upsertStatus is Success to removed",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(
          TvSeriesDetailState(
            tvSeries: testTvSeriesDetail,
            watchlistStatus: true,
            upsertStatus: TvSeriesDetailUpsertSuccess('Removed from watchlist'),
          ),
        ),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          watchlistStatus: true,
          upsertStatus: TvSeriesDetailUpsertSuccess('Removed from watchlist'),
        ),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);
      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from watchlist'), findsOneWidget);
    },
  );

  testWidgets(
    "Page should display AlertDialog when upsertStatus is Failure",
    (WidgetTester tester) async {
      when(mockTvSeriesDetailBloc.stream).thenAnswer(
        (_) => Stream.value(
          TvSeriesDetailState(
            tvSeries: testTvSeriesDetail,
            watchlistStatus: false,
            upsertStatus: TvSeriesDetailUpsertFailure('Failure'),
          ),
        ),
      );
      when(mockTvSeriesDetailBloc.state).thenAnswer(
        (_) => TvSeriesDetailState(
          tvSeries: testTvSeriesDetail,
          watchlistStatus: false,
          upsertStatus: TvSeriesDetailUpsertFailure('Failure'),
        ),
      );
      when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
      );
      when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
        (_) => TvSeriesRecommendationsSuccess(tvSeries: testTvSeriesList),
      );

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(watchlistButton, warnIfMissed: false);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failure'), findsOneWidget);
    },
  );

  group("Recomendations", () {
    testWidgets(
      "Page should display progress bar when the data is InProgress",
      (WidgetTester tester) async {
        when(mockTvSeriesDetailBloc.stream).thenAnswer(
          (_) => Stream.value(const TvSeriesDetailState()),
        );
        when(mockTvSeriesDetailBloc.state).thenAnswer(
          (_) => TvSeriesDetailState(tvSeries: testTvSeriesDetail),
        );
        when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
        );
        when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
          (_) => TvSeriesRecommendationsInProgress(),
        );

        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error with message when error",
      (WidgetTester tester) async {
        when(mockTvSeriesDetailBloc.stream).thenAnswer(
          (_) => Stream.value(const TvSeriesDetailState()),
        );
        when(mockTvSeriesDetailBloc.state).thenAnswer(
          (_) => TvSeriesDetailState(tvSeries: testTvSeriesDetail),
        );
        when(mockTvSeriesRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const TvSeriesRecommendationsInProgress()),
        );
        when(mockTvSeriesRecommendationsCubit.state).thenAnswer(
          (_) => TvSeriesRecommendationsFailure(message: 'Not found'),
        );

        final textFinder = find.text('Not found');

        await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
