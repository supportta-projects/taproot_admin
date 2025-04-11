import '/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      
      //TODO : step 3: uncomment the line below to use the onGenerateInitialRoute method
      onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoute,
    );
  }
}
