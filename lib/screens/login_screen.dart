import 'package:attendance_app/components/neumorphic_button.dart';
import 'package:attendance_app/components/neumorphic_text_field.dart';
import 'package:attendance_app/constants/constants.dart';
import 'package:attendance_app/constants/utils.dart';
import 'package:attendance_app/firebaseservices/auth_setup.dart';
import 'package:attendance_app/provider/password_visibility_provider.dart';
import 'package:attendance_app/screens/reset_password_screen.dart';
import 'package:attendance_app/screens/signup_screen.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final authSetup = Provider.of<AuthSetup>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          height: height * 0.65,
          width: width * 0.87,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              const BoxShadow(
                color: Colors.white,
                blurRadius: 10,
                offset: Offset(-10, -10),
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                blurRadius: 20,
                offset: const Offset(10, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'L O G I N',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  NeumorphicTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    title: 'E M A I L',
                    prefix: const Icon(Icons.alternate_email_rounded),
                    focusNode: emailFocusNode,
                    onFieldSubmitted: (value) {
                      Utils.changeFocus(
                          currentFocus: emailFocusNode,
                          nextFocus: passwordFocusNode,
                          context: context);
                    },
                    validator: (value) => authSetup.validateEmail(value!),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<PasswordVisibilityProvider>(
                    builder: (BuildContext context,
                        PasswordVisibilityProvider value, Widget? child) {
                      return NeumorphicTextField(
                        prefix: const Icon(Icons.lock_outline_rounded),
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        title: 'P A S S W O R D',
                        focusNode: passwordFocusNode,
                        obscureText: value.isObscure,
                        suffix: GestureDetector(
                          onTap: value.setVisibility,
                          child: Icon(value.isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        validator: (value) =>
                            authSetup.validatePassword(value!),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ResetPasswordScreen(),),);
                      },
                      child: const Text(
                        textAlign: TextAlign.right,
                        'Forgot password?',
                      ),
                    ),
                  ),
                  
                  Consumer<AuthSetup>(
                    builder: (BuildContext context, value, Widget? child) {
                      return NeumorphicButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            value.login(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context);
                          }
                        },
                        isLoading: value.loading,
                        child: const Text('L O G I N'),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<AuthSetup>(
                    builder: (BuildContext context,AuthSetup value, Widget? child) { return      Row(
                      children: [
                        Expanded(
                          child: NeumorphicButton(
                            onTap: () {value.googleSignIn(context:  context);},
                            isLoading: value.googleAuthLoading,
                            child: Image.asset(
                              Constants.googleLogo,
                              width: 65,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: NeumorphicButton(
                            onTap: () {value.facebookSignIn(context:  context);},
                            isLoading: value.facebookAuthLoading,
                            child: Image.asset(
                              Constants.facebookLogo,
                              width: 75,
                            ),
                          ),
                        ),
                      ],
                    );
          },
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: const Text('Register'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
