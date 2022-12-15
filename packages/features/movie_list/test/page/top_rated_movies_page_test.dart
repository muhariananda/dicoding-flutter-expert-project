import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/movie_list.dart';

import '../dummy_movie.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMovieCubit])
void main() {
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;

  setUp(() {
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieCubit>.value(
      value: mockTopRatedMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display centered progress bar when state is InProgress",
    (WidgetTester tester) async {
      when(mockTopRatedMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedMovieInProgress()));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => const TopRatedMovieInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display listView when state is Success",
    (WidgetTester tester) async {
      when(mockTopRatedMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedMovieInProgress()));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => TopRatedMovieSuccess(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockTopRatedMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedMovieInProgress()));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => const TopRatedMovieFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
