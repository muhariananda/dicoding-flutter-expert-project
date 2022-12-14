import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_detail/movie_detail.dart';

import '../dummy_movie.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailCubit,
  MovieRecommendationsCubit,
])
void main() {
  late MockMovieDetailCubit mockMovieDetailCubit;
  late MockMovieRecommendationsCubit mockMovieRecommendationsCubit;

  setUp(() {
    mockMovieDetailCubit = MockMovieDetailCubit();
    mockMovieRecommendationsCubit = MockMovieRecommendationsCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailCubit>.value(
          value: mockMovieDetailCubit,
        ),
        BlocProvider<MovieRecommendationsCubit>.value(
          value: mockMovieRecommendationsCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display centered progress bar when state of movie is null",
    (WidgetTester tester) async {
      when(mockMovieDetailCubit.stream)
          .thenAnswer((_) => Stream.value(const MovieDetailState()));
      when(mockMovieDetailCubit.state)
          .thenAnswer((_) => const MovieDetailState());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display Detail Content when state of movie is not null",
    (WidgetTester tester) async {
      when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailState()),
      );
      when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()));
      when(mockMovieDetailCubit.state).thenAnswer(
        (_) => MovieDetailState(
          movie: testMovieDetail,
        ),
      );
      when(mockMovieRecommendationsCubit.state).thenAnswer(
        (_) => MovieRecommendationsSuccess(movies: testMovieList),
      );

      final contentFinder = find.byType(DetailContent);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(contentFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state of error is not null",
    (WidgetTester tester) async {
      when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailState()),
      );
      when(mockMovieDetailCubit.state).thenAnswer(
        (_) => const MovieDetailState(
          errorMessage: 'Not found',
        ),
      );

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieDetailState()),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailCubit.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: false,
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieDetailState()),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailCubit.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: true,
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Page should display SnackBar with message when upsertStatus is Succes to added',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
      (_) => Stream.value(
        MovieDetailState(
          movie: testMovieDetail,
          watchlistStatus: false,
          upsertStatus: const MovieDetailUpsertSuccess('Added to Watchlist'),
        ),
      ),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailCubit.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: false,
        upsertStatus: const MovieDetailUpsertSuccess('Added to Watchlist'),
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Page should display Snackbar with message when UpsertStatus is Success to removed',
      (WidgetTester tester) async {
    when(mockMovieDetailCubit.stream).thenAnswer(
      (_) => Stream.value(
        MovieDetailState(
          movie: testMovieDetail,
          watchlistStatus: true,
          upsertStatus: const MovieDetailUpsertSuccess('Removed to Watchlist'),
        ),
      ),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailCubit.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: true,
        upsertStatus: const MovieDetailUpsertSuccess('Removed to Watchlist'),
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final iconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(iconFinder, findsOneWidget);
    await tester.tap(iconFinder);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed to Watchlist'), findsOneWidget);
  });

  testWidgets(
    'Page should display AlertDialog when UpsertStatus is Failure',
    (WidgetTester tester) async {
      when(mockMovieDetailCubit.stream).thenAnswer(
        (_) => Stream.value(
          MovieDetailState(
            movie: testMovieDetail,
            watchlistStatus: false,
            upsertStatus: const MovieDetailUpsertFailure('Failure'),
          ),
        ),
      );
      when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsInProgress()),
      );
      when(mockMovieDetailCubit.state).thenAnswer(
        (_) => MovieDetailState(
          movie: testMovieDetail,
          upsertStatus: const MovieDetailUpsertFailure('Failure'),
        ),
      );
      when(mockMovieRecommendationsCubit.state).thenAnswer(
        (_) => MovieRecommendationsSuccess(movies: testMovieList),
      );

      final buttonFinder = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

      expect(buttonFinder, findsOneWidget);
      await tester.ensureVisible(buttonFinder);
      await tester.tap(buttonFinder, warnIfMissed: false);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failure'), findsOneWidget);
    },
  );

  group("Movie recommendations", () {
    testWidgets(
      "should display centered progress bar when data is Loading",
      (WidgetTester tester) async {
        when(mockMovieDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailCubit.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => const MovieRecommendationsInProgress(),
        );

        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display ListView when data was Loaded",
      (WidgetTester tester) async {
        when(mockMovieDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailCubit.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => MovieRecommendationsSuccess(movies: testMovieList),
        );

        final listViewFinder = find.byType(ListView);

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display text with message when error",
      (WidgetTester tester) async {
        when(mockMovieDetailCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailCubit.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => const MovieRecommendationsFailure(message: 'Not found'),
        );

        final textFinder = find.text('Not found');

        await tester
            .pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
