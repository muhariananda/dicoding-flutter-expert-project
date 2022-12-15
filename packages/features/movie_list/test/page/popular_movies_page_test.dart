import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_list/movie_list.dart';

import '../dummy_movie.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMovieCubit])
void main() {
  late MockPopularMovieCubit mockPopularMovieCubit;

  setUp(() {
    mockPopularMovieCubit = MockPopularMovieCubit();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieCubit>.value(
      value: mockPopularMovieCubit,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display centered progress bar when state is InProgress",
    (WidgetTester tester) async {
      when(mockPopularMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularMovieInProgress()));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => const PopularMovieInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display verticaled movie listview when state is Success",
    (WidgetTester tester) async {
      when(mockPopularMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularMovieInProgress()));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => PopularMovieSuccess(testMovieList));

      final verticaledListViewFinder = find.byType(VerticaledMovieList);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(verticaledListViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockPopularMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularMovieInProgress()));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => const PopularMovieFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
