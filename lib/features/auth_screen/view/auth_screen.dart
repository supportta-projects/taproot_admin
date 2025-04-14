import 'package:flutter/material.dart';
import '/features/side_nav_screen/view/side_drawer_nav_screen.dart';

import 'package:taproot_admin/widgets/loading_button.dart';
import '/exporter/exporter.dart';
import '/mixins/name_mixin.dart';

class AuthScreen extends StatefulWidget {
  static const String path = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with NameMixin {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = SizeUtils.width;
    final screenHeight = SizeUtils.height;

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.6,
          decoration: BoxDecoration(
            color: CustomColors.secondaryColor,
            borderRadius: BorderRadius.circular(CustomPadding.padding),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomPadding.paddingXL,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LOGO'),
                  nameField(),
                  CustomGap.gapLarge,
                  TextFormField(
                    obscureText: _obsecureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: CustomColors.textColorGrey),
                      suffixIcon: IconButton(
                        icon:
                            _obsecureText
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obsecureText = !_obsecureText;
                          });
                        },
                      ),
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Password is required"
                                : null,
                  ),
                  CustomGap.gapLarge,
                  LoadingButton(
                    buttonLoading: false,
                    text: "Login",
                    onPressed: () {
                      Navigator.of(context).pushNamed(SideDrawerNavScreen.path);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
