import '/features/landing_screen/landing_page.dart';
import 'package:flutter/material.dart';

import '../core/logger.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final Uri uri = Uri.parse(settings.name!);

    logInfo(uri);

    switch (uri.path) {
      case LandingPage.path:
        return pageRoute(
          settings,
          const LandingPage(),
        );
      default:
        return null;
    }
  }

  static List<Route<dynamic>> onGenerateInitialRoute(String path) {
    Uri uri = Uri.parse(path);

    logInfo(uri);

    //if shared preference Service is null , we can navigate to the landing page
    //if shared preference Service is not null , we can navigate to the splash Screen then to home page

    return [
      pageRoute(
        const RouteSettings(name: LandingPage.path),
        const LandingPage(),
      ),
    ];
  }

  static Route<T> pageRoute<T>(
    RouteSettings settings,
    Widget screen, {
    bool animate = true,
  }) {
    if (!animate) {
      return PageRouteBuilder(
        settings: settings,
        opaque: true,
        pageBuilder: (context, animation, secondaryAnimation) => screen,
      );
    }
    return MaterialPageRoute(settings: settings, builder: (context) => screen);
  }
}
