import 'package:flutter/material.dart';
import 'package:taproot_admin/extensions/font_extension.dart';
import 'package:taproot_admin/services/size_utils.dart';

class AuthScreen extends StatelessWidget {
  //TODO : step 1 :  implement shared preference service using shaerd pref package, then go to app routes page
  static const String path = '/auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO : step 1.1 : implement a button to nav to home page after authentication, use the shaed pref service to save weather the user is already signed in or not
    return Scaffold(
      body: Center(child: Text('Auth Screen', style: context.inter50016.copyWith(fontSize: 16.fSize))),
    );
  }
}
