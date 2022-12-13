import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/page/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'popular_movies_page_test.mocks.dart';


@GenerateMocks([PopularMovieCubit])
void main() {
  late MockPopularMovieCubit mockPopularMovieCubit;

  setUp(() {
    mockPopularMovieCubit = MockPopularMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
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
          .thenAnswer((_) => PopularMovieInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

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

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(verticaledListViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockPopularMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const PopularMovieInProgress()));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => PopularMovieFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
