import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/components/components.dart';
import 'package:ditonton/features/home/page/home_movie_page.dart';
import 'package:ditonton/features/home/provider/movie_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/movie/dummy_movie.dart';
import 'home_movie_page_test.mocks.dart';

@GenerateMocks([MovieListNotifier])
void main() {
  late MockMovieListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieListNotifier();
  });

  Widget _makeTestbaleWidget(Widget body) {
    return ChangeNotifierProvider<MovieListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display all progress bar when the is Loading",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loading);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loading);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loading);

      final progressBarFinder = find.byType(CenteredProgressCircularIndicator);

      await tester.pumpWidget(_makeTestbaleWidget(HomeMoviePage()));

      expect(progressBarFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display all listview when the data is Loaded",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Loaded);
      when(mockNotifier.nowPlayingMovies).thenReturn(testMovieList);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.popularMovies).thenReturn(testMovieList);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Loaded);
      when(mockNotifier.topRatedMovies).thenReturn(testMovieList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestbaleWidget(HomeMoviePage()));

      expect(listViewFinder, findsNWidgets(3));
    },
  );

  testWidgets(
    "Page should display text error with message when error",
    (WidgetTester tester) async {
      when(mockNotifier.nowPlayingState).thenReturn(RequestState.Error);
      when(mockNotifier.popularMoviesState).thenReturn(RequestState.Error);
      when(mockNotifier.topRatedMoviesState).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestbaleWidget(HomeMoviePage()));

      expect(textFinder, findsNWidgets(3));
    },
  );
}
