import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:ditonton/feature/movie_detail/cubit/movie_recommendations_cubit.dart';
import 'package:ditonton/feature/movie_detail/page/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([
  MovieDetailBloc,
  MovieRecommendationsCubit,
])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsCubit mockMovieRecommendationsCubit;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsCubit = MockMovieRecommendationsCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(
          value: mockMovieDetailBloc,
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
      when(mockMovieDetailBloc.stream)
          .thenAnswer((_) => Stream.value(const MovieDetailState()));
      when(mockMovieDetailBloc.state).thenAnswer((_) => MovieDetailState());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display Detail Content when state of movie is not null",
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailState()),
      );
      when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()));
      when(mockMovieDetailBloc.state).thenAnswer(
        (_) => MovieDetailState(
          movie: testMovieDetail,
        ),
      );
      when(mockMovieRecommendationsCubit.state).thenAnswer(
        (_) => MovieRecommendationsSuccess(movies: testMovieList),
      );

      final contentFinder = find.byType(DetailContent);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(contentFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state of error is not null",
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.stream).thenAnswer(
        (_) => Stream.value(const MovieDetailState()),
      );
      when(mockMovieDetailBloc.state).thenAnswer(
        (_) => MovieDetailState(
          errorMessage: 'Not found',
        ),
      );

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer(
      (_) => Stream.value(const MovieDetailState()),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailBloc.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: false,
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer(
      (_) => Stream.value(const MovieDetailState()),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailBloc.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: true,
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Page should display SnackBar with message when upsertStatus is Succes to added',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer(
      (_) => Stream.value(
        MovieDetailState(
          movie: testMovieDetail,
          watchlistStatus: false,
          upsertStatus: MovieDetailUpsertSuccess('Added to Watchlist'),
        ),
      ),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailBloc.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: false,
        upsertStatus: MovieDetailUpsertSuccess('Added to Watchlist'),
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Page should display Snackbar with message when UpsertStatus is Success to removed',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer(
      (_) => Stream.value(
        MovieDetailState(
          movie: testMovieDetail,
          watchlistStatus: true,
          upsertStatus: MovieDetailUpsertSuccess('Removed to Watchlist'),
        ),
      ),
    );
    when(mockMovieRecommendationsCubit.stream).thenAnswer(
      (_) => Stream.value(const MovieRecommendationsInProgress()),
    );
    when(mockMovieDetailBloc.state).thenAnswer(
      (_) => MovieDetailState(
        movie: testMovieDetail,
        watchlistStatus: true,
        upsertStatus: MovieDetailUpsertSuccess('Removed to Watchlist'),
      ),
    );
    when(mockMovieRecommendationsCubit.state).thenAnswer(
      (_) => MovieRecommendationsSuccess(movies: testMovieList),
    );

    final iconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(iconFinder, findsOneWidget);
    await tester.tap(iconFinder);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed to Watchlist'), findsOneWidget);
  });

  testWidgets(
    'Page should display AlertDialog when UpsertStatus is Failure',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.stream).thenAnswer(
        (_) => Stream.value(
          MovieDetailState(
            movie: testMovieDetail,
            watchlistStatus: false,
            upsertStatus: MovieDetailUpsertFailure('Failure'),
          ),
        ),
      );
      when(mockMovieRecommendationsCubit.stream).thenAnswer(
        (_) => Stream.value(const MovieRecommendationsInProgress()),
      );
      when(mockMovieDetailBloc.state).thenAnswer(
        (_) => MovieDetailState(
          movie: testMovieDetail,
          upsertStatus: MovieDetailUpsertFailure('Failure'),
        ),
      );
      when(mockMovieRecommendationsCubit.state).thenAnswer(
        (_) => MovieRecommendationsSuccess(movies: testMovieList),
      );

      final buttonFinder = find.byType(ElevatedButton);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

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
        when(mockMovieDetailBloc.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailBloc.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => MovieRecommendationsInProgress(),
        );

        final progressBarFinder =
            find.byType(CenteredProgressCircularIndicator);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(progressBarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display ListView when data was Loaded",
      (WidgetTester tester) async {
        when(mockMovieDetailBloc.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailBloc.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => MovieRecommendationsSuccess(movies: testMovieList),
        );

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "should display text with message when error",
      (WidgetTester tester) async {
        when(mockMovieDetailBloc.stream).thenAnswer(
          (_) => Stream.value(const MovieDetailState()),
        );
        when(mockMovieRecommendationsCubit.stream).thenAnswer(
          (_) => Stream.value(const MovieRecommendationsInProgress()),
        );
        when(mockMovieDetailBloc.state).thenAnswer(
          (_) => MovieDetailState(
            movie: testMovieDetail,
          ),
        );
        when(mockMovieRecommendationsCubit.state).thenAnswer(
          (_) => MovieRecommendationsFailure(message: 'Not found'),
        );

        final textFinder = find.text('Not found');

        await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

        expect(textFinder, findsOneWidget);
      },
    );
  });
}
