import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:ditonton/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    "Ditonton test",
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final ScaffoldState state = tester.firstState(find.byType(Scaffold));

      expect(find.byType(ListView), findsWidgets);

      //to tv show
      final tvIconFinder = find.byIcon(Icons.tv);
      expect(tvIconFinder, findsOneWidget);
      await tester.tap(tvIconFinder);
      await tester.pump();

      expect(find.byType(ListView), findsWidgets);

      //search content
      final searchFinder = find.byIcon(Icons.search);
      expect(searchFinder, findsOneWidget);
      await tester.tap(searchFinder);
      await tester.pumpAndSettle();

      final searchBarFinder = find.byKey(Key('search_bar'));
      expect(searchBarFinder, findsOneWidget);
      await tester.enterText(searchBarFinder, 'Hulk');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(ListView), findsOneWidget);

      //detail movie
      await tester.tap(find.byKey(Key('movie0')));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);

      // add movie watchlist
      final addIconFinder = find.byIcon(Icons.add);
      expect(addIconFinder, findsOneWidget);
      await tester.tap(addIconFinder);
      await tester.pumpAndSettle();
      expect(find.text('Added to Watchlist'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      //search tv
      final tvChipFinder = find.byKey(Key('tv_series_filter_chip'));
      expect(tvChipFinder, findsOneWidget);
      await tester.tap(tvChipFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.byType(ListView), findsOneWidget);

      await tester.tap(find.byKey(Key('tvSeries0')));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsNWidgets(2));

      //added tv series watchlist
      expect(addIconFinder, findsOneWidget);
      await tester.tap(addIconFinder);
      await tester.pumpAndSettle();
      expect(find.text('Added to watchlist'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.pageBack();

      //get watchlist
      state.openDrawer();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Watchlist'));
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);

      await tester.tap(find.byKey(Key('movie0')));
      await tester.pumpAndSettle();

      //remove watchlist
      final checkIconFinder = find.byIcon(Icons.check);
      expect(checkIconFinder, findsOneWidget);
      await tester.tap(checkIconFinder);
      await tester.pumpAndSettle();
      expect(find.text('Removed from Watchlist'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(tvChipFinder, findsOneWidget);
      await tester.tap(tvChipFinder);
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);

      await tester.tap(find.byKey(Key('tvSeries0')));
      await tester.pumpAndSettle();

      expect(checkIconFinder, findsOneWidget);
      await tester.tap(checkIconFinder);
      await tester.pumpAndSettle();
      expect(find.text('Removed from Watchlist'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.pageBack();
    },
  );
}
