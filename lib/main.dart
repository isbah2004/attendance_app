import 'package:attendance_app/firebase_options.dart';
import 'package:attendance_app/firebaseservices/auth_setup.dart';
import 'package:attendance_app/provider/password_visibility_provider.dart';
import 'package:attendance_app/screens/signup_screen.dart';
import 'package:attendance_app/theme/light_mode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (context) => AuthSetup())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tracker App',
        home: const SignupScreen(),
        theme: LightMode.lightTheme,
      ),
    ),
  );
}
