import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';

class AnalyticsSerivce {
  final FirebaseAnalytics _analytics;

  AnalyticsSerivce({
    @visibleForTesting FirebaseAnalytics? analytics,
  }) : _analytics = analytics ?? FirebaseAnalytics.instance;

  Future<void> setCurrentScreen(String screenName) async {
    return _analytics.setCurrentScreen(
      screenName: screenName,
    );
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object?>? paramenters,
  }) {
    return _analytics.logEvent(
      name: name,
      parameters: paramenters,
    );
  }
}
