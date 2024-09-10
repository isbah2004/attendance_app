import 'package:attendance_app/components/neumorphic_button.dart';
import 'package:attendance_app/components/neumorphic_text_field.dart';
import 'package:attendance_app/firebaseservices/auth_setup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthSetup>(context, listen: false);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          height: height * 0.4,
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'R E S E T   P A S S W O R D',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 30,
                ),
                NeumorphicTextField(focusNode: emailFocusNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  title: 'E M A I L',
                  prefix: const Icon(Icons.alternate_email_rounded),
                  validator: (value) => authProvider.validateEmail(value!),
                ),
                const SizedBox(
                  height: 30,
                ),
                Consumer<AuthSetup>(
                  builder:
                      (BuildContext context, AuthSetup value, Widget? child) {
                    return NeumorphicButton(
                      onTap: () {value.resetPassword(email: emailController.text.trim(), context: context);},
                      isLoading: value.loading,
                      child: const Text('R E S E T'),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
