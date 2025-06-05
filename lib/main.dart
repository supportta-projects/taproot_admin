import 'dart:io';
import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/services/shared_pref_services.dart';
import 'package:taproot_admin/services/size_utils.dart';
import 'package:window_size/window_size.dart';
import '/theme/theme.dart';
import '/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.i.initialize();
  await DioHelper().init();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    final screen = await getCurrentScreen();

    if (screen != null) {
      final screenFrame = screen.frame;
      setWindowFrame(screenFrame);
    }
  }
  final token = SharedPreferencesService.i.token;
  final initialRoute = (token.isEmpty) ? '/auth' : '/sideDrawerNav';
  runApp(MyApp(initialRoute: initialRoute));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder:
          (context, orientation, deviceType) => MaterialApp(
            navigatorKey: navigatorKey,
            builder: (context, child) {
              // Get the max width and height from MediaQuery
              final size = MediaQuery.of(context).size;
              return SizedBox(
                width: size.width,
                height: size.height,
                child: child,
              );
            },

            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            // theme: ThemeData(
            //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            // ),
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            initialRoute: initialRoute,
            //TODO : step 3: uncomment the line below to use the onGenerateInitialRoute method
            onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoute,
          ),
    );
  }
}
