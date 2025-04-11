import 'package:taproot_admin/features/auth_screen/view/auth_screen.dart';

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

    //TODO: step 2: use the shared pref value to navigate to the side navigation page or the auth page

    //if shared preference Service is null , we can navigate to the landing page
    //if shared preference Service is not null , we can navigate to the splash Screen then to home page

    return [
      pageRoute(
         RouteSettings(name: AuthScreen.path),
        const AuthScreen(),
        animate: false,
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
