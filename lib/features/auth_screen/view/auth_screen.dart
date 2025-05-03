import 'package:flutter/material.dart';
import 'package:taproot_admin/features/auth_screen/data/auth_service.dart';
import '/features/side_nav_screen/view/side_drawer_nav_screen.dart';

import 'package:taproot_admin/widgets/loading_button.dart';
import '/exporter/exporter.dart';

class AuthScreen extends StatefulWidget {
  static const String path = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = SizeUtils.width;
    final screenHeight = SizeUtils.height;

    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body:
          isLoading
              ? CircularProgressIndicator()
              : Center(
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

                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: CustomColors.textColorGrey,
                              ),
                            ),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Email is required'
                                        : null,
                          ),
                          CustomGap.gapLarge,
                          TextFormField(
                            controller: passwordController,
                            obscureText: _obsecureText,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: CustomColors.textColorGrey,
                              ),
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
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  isLoading = true;
                                });
                                try {
                                  await AuthService.loginAdmin(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                                  Navigator.of(context).pushReplacementNamed(
                                    SideDrawerNavScreen.path,
                                  );
                                } catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Login failed: $e')),
                                  );
                                }
                              }
                              // Navigator.of(context).pushNamed(SideDrawerNavScreen.path);
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
