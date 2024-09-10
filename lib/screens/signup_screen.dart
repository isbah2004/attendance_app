import 'package:attendance_app/components/neumorphic_button.dart';
import 'package:attendance_app/components/neumorphic_text_field.dart';
import 'package:attendance_app/constants/constants.dart';
import 'package:attendance_app/constants/utils.dart';
import 'package:attendance_app/firebaseservices/auth_setup.dart';
import 'package:attendance_app/provider/password_visibility_provider.dart';
import 'package:attendance_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
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
    final authProvider = Provider.of<AuthSetup>(context, listen: false);
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
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'S I G N U P',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                      validator: (value) => authProvider.validateEmail(value!),
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
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          validator: (value) =>
                              authProvider.validatePassword(value!),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AuthSetup>(
                      builder: (BuildContext context, AuthSetup value,
                          Widget? child) {
                        return NeumorphicButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              value.register(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  context: context);
                            }
                          },
                          isLoading: value.loading,
                          child: const Text('S I G N U P'),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<AuthSetup>(
                      builder: (BuildContext context, AuthSetup value,
                          Widget? child) {
                        return Row(
                          children: [
                            Expanded(
                              child: NeumorphicButton(
                                onTap: () {
                                  value.googleSignIn(context: context);
                                },
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
                                onTap: () {
                                  value.facebookSignIn(context: context);
                                },
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
