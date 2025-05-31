import 'package:flutter/material.dart';
import 'package:taproot_admin/features/auth_screen/data/auth_service.dart';
import 'package:taproot_admin/gen/assets.gen.dart';
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
    emailController.text = 'admin@supporttacards.com';
    passwordController.text = 'Admin@Supportta765';

    final screenWidth = SizeUtils.width;
    final screenHeight = SizeUtils.height;

    return Scaffold(
      // backgroundColor: Colors.green.shade100,
      body: Container(
        decoration: BoxDecoration(gradient: CustomColors.borderGradient),
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                  child: Container(
                    width: screenWidth * 0.80,
                    height: screenHeight * 0.7,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        radius: 0.3,
                        center: Alignment(-0.2, -0.25),
                        colors: [
                          Color(0xFfFAAD4F),
                          CustomColors.secondaryColor,
                        ],
                      ),
                      color: CustomColors.secondaryColor,
                      borderRadius: BorderRadius.circular(
                        CustomPadding.paddingLarge,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            // width: screenWidth * 0.5,
                            height: screenHeight * 0.5,
                            child: Image.asset(
                              Assets.png.group1321314488.path,
                              // fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Expanded(
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
                                    // initialValue: "admin@supporttacards.com",
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
                                    // initialValue: "Admin@Supportta765",
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
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        try {
                                          await AuthService.loginAdmin(
                                            ///
                                            //TODO
                                            email: emailController.text.trim(),
                                            password:
                                                passwordController.text.trim(),
                                            // password: "Admin@Supportta765",
                                            // email: "admin@supporttacards.com",
                                          );

                                          //TODO : fix context
                                          Navigator.of(
                                            context,
                                          ).pushReplacementNamed(
                                            SideDrawerNavScreen.path,
                                          );
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Login failed: $e'),
                                            ),
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
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
