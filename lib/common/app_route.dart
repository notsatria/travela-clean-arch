import 'package:flutter/material.dart';

class AppRoute {
  static const dashboard = '/';
  static const destinationDetail = '/destination/detail';
  static const destinationSearch = '/destination/search';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const Placeholder(),
          settings: settings,
        );
      case destinationDetail:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const Placeholder(),
          settings: settings,
        );
      case destinationSearch:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const Placeholder(),
          settings: settings,
        );
      default:
        return _notFoundRoute(settings);
    }
  }

  static MaterialPageRoute _notFoundRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page Not Found'),
        ),
      ),
      settings: settings,
    );
  }
}
