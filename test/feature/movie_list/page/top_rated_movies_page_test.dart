import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/page/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMovieCubit])
void main() {
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;

  setUp(() {
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
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
          .thenAnswer((_) => TopRatedMovieInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

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

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display text error message when state is Failure",
    (WidgetTester tester) async {
      when(mockTopRatedMovieCubit.stream)
          .thenAnswer((_) => Stream.value(const TopRatedMovieInProgress()));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => TopRatedMovieFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

      expect(textFinder, findsOneWidget);
    },
  );
}
