import 'package:taproot_admin/core/api/dio_helper.dart';
import 'package:taproot_admin/services/shared_pref_services.dart';
import 'package:taproot_admin/services/size_utils.dart';

import '/theme/theme.dart';

import '/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.i.initialize(); 
  await DioHelper().init();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(

      builder: (context, orientation, deviceType) => 
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // ),
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      
        //TODO : step 3: uncomment the line below to use the onGenerateInitialRoute method
        onGenerateInitialRoutes: AppRoutes.onGenerateInitialRoute,
      ),
    );
  }
}
