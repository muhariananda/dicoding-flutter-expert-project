import 'package:flutter/material.dart';

import 'package:ditonton/monitoring/analytics_service.dart';

class ScreenViewObserver extends NavigatorObserver {
  final AnalyticsSerivce analyticsSerivce;

  ScreenViewObserver({
    required this.analyticsSerivce,
  });

  void _sendScreenView(PageRoute<dynamic> route) {
    final String? screenName = route.settings.name;

    if (screenName != null) {
      analyticsSerivce.setCurrentScreen(screenName);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
    }
  }
}
