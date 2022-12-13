import 'package:ditonton/components/components.dart';
import 'package:ditonton/feature/movie_list/cubit/now_playing_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/popular_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/cubit/top_rated_movie_cubit.dart';
import 'package:ditonton/feature/movie_list/page/movie_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'movie_list_page_test.mocks.dart';

@GenerateMocks([
  NowPlayingMovieCubit,
  PopularMovieCubit,
  TopRatedMovieCubit,
])
void main() {
  late MockNowPlayingMovieCubit mockNowPlayingMovieCubit;
  late MockPopularMovieCubit mockPopularMovieCubit;
  late MockTopRatedMovieCubit mockTopRatedMovieCubit;

  setUp(() {
    mockNowPlayingMovieCubit = MockNowPlayingMovieCubit();
    mockPopularMovieCubit = MockPopularMovieCubit();
    mockTopRatedMovieCubit = MockTopRatedMovieCubit();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieCubit>.value(
          value: mockNowPlayingMovieCubit,
        ),
        BlocProvider<PopularMovieCubit>.value(
          value: mockPopularMovieCubit,
        ),
        BlocProvider<TopRatedMovieCubit>.value(
          value: mockTopRatedMovieCubit,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  void _makeStreamStub() {
    when(mockNowPlayingMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const NowPlayingMovieInProgress()));
    when(mockPopularMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const PopularMovieInProgress()));
    when(mockTopRatedMovieCubit.stream).thenAnswer(
        (_) => Stream.value(const TopRatedMovieInProgress()));
  }

  testWidgets(
    "Page should display 3 centered progress bars when all movie states are InProgress",
    (WidgetTester tester) async {
      _makeStreamStub();
      when(mockNowPlayingMovieCubit.state)
          .thenAnswer((_) => NowPlayingMovieInProgress());
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => PopularMovieInProgress());
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => TopRatedMovieInProgress());

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(progressBarFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 listviews when all movie states are Success",
    (WidgetTester tester) async {
      _makeStreamStub();
      when(mockNowPlayingMovieCubit.state)
          .thenAnswer((_) => NowPlayingMovieSuccess(testMovieList));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => PopularMovieSuccess(testMovieList));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => TopRatedMovieSuccess(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display 3 centered texts when all movie states are Failure",
    (WidgetTester tester) async {
      _makeStreamStub();
      when(mockNowPlayingMovieCubit.state)
          .thenAnswer((_) => NowPlayingMovieFailure('Not found'));
      when(mockPopularMovieCubit.state)
          .thenAnswer((_) => PopularMovieFailure('Not found'));
      when(mockTopRatedMovieCubit.state)
          .thenAnswer((_) => TopRatedMovieFailure('Not found'));

      final textFinder = find.text('Not found');

      await tester.pumpWidget(_makeTestableWidget(MovieListPage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
