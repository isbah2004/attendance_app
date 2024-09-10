import 'package:attendance_app/constants/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthSetup extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  bool _loading = false;
  bool _googleAuthLoading = false;
  bool _facebookAuthLoading = false;
  bool get loading => _loading;
  bool get googleAuthLoading => _googleAuthLoading;
  bool get facebookAuthLoading => _facebookAuthLoading;
  setGoogleAuthLoading(value) {
    _googleAuthLoading = value;
    notifyListeners();
  }

  setFacebookAuthLoading(value) {
    _facebookAuthLoading = value;
    notifyListeners();
  }

  setLoading(value) {
    _loading = value;
    notifyListeners();
  }

  void register({required email, required password, required context}) async {
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Utils.showSuccessFlushbar(
          context: context, message: 'User created successfully');
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
    } catch (e) {
      handleGenericException(e, context);
    } finally {
      setLoading(false);
    }
  }

  void login({required email, required password, required context}) async {
    setLoading(true);
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
      Utils.showSuccessFlushbar(context: context, message: 'Login Successful');
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
    } catch (e) {
      handleGenericException(e, context);
    } finally {
      setLoading(false);
    }
  }

  void resetPassword({required email, required context}) async {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email);
      Utils.showSuccessFlushbar(
          context: context, message: 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
    } catch (e) {
      handleGenericException(e, context);
    } finally {
      setLoading(true);
    }
  }

  googleSignIn({required context}) async {
    setGoogleAuthLoading(true);
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      if (googleSignInAccount == null) return;

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );
      return await auth.signInWithCredential(credential).then((value) {
        Utils.showSuccessFlushbar(
            context: context, message: 'Login Successful');
      });
    } on FirebaseAuthException catch (e) {
      handleFirebaseAuthException(e, context);
    } catch (e) {
      handleGenericException(e, context);
    } finally {
      setGoogleAuthLoading(false);
    }
  }

  Future<UserCredential?> facebookSignIn({required context}) async {
    setFacebookAuthLoading(true);
    try {
     final facebookLogin = FacebookLogin();
     final result = await facebookLogin.logIn(permissions: [
  FacebookPermission.publicProfile,
  FacebookPermission.email,
  
]);
      if (result.status == FacebookLoginStatus.error || result.accessToken == null) {
        setFacebookAuthLoading(false);
        return null;
      }
      final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(facebookCredential);
      Utils.showSuccessFlushbar(
          context: context, message: 'Successfully signed in with Facebook');

      return userCredential;
    } catch (e) {
      String errorMessage;
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'account-exists-with-different-credential':
            errorMessage = 'Account exists with a different credential.';
            break;
          case 'invalid-credential':
            errorMessage = 'Invalid Facebook credential.';
            break;
          default:
            errorMessage = 'An unknown error occurred.';
            break;
        }
      } else {
        errorMessage = 'An error occurred during Facebook sign-in.';
      }

      Utils.showErrorFlushbar(context: context, message: errorMessage, e: e);

      return null;
    } finally {
      setFacebookAuthLoading(false);
    }
  }

  void handleFirebaseAuthException(
      FirebaseAuthException e, BuildContext context) {
    String errorMessage;

    switch (e.code) {
      case 'invalid-email':
        errorMessage = "Invalid email. Please try again.";
        break;
      case 'user-disabled':
        errorMessage = "Account disabled. Contact support.";
        break;
      case 'user-not-found':
        errorMessage = "No user found. Check email or sign up.";
        break;
      case 'wrong-password':
        errorMessage = "Wrong password. Try again.";
        break;
      case 'email-already-in-use':
        errorMessage = "Email in use. Log in or reset password.";
        break;
      case 'operation-not-allowed':
        errorMessage = "Operation not allowed.";
        break;
      case 'weak-password':
        errorMessage = "Weak password. Choose a stronger one.";
        break;
      case 'too-many-requests':
        errorMessage = "Too many attempts. Try later.";
        break;
      default:
        errorMessage = "Unexpected error. Try again.";
    }

    debugPrint("FirebaseAuthException: ${e.code} - ${e.message}");

    Utils.showErrorFlushbar(context: context, message: errorMessage, e: e);
  }

  void handleGenericException(dynamic e, context) {
    Utils.showErrorFlushbar(
      context: context,
      message: 'Some unexpected error occured.',
      e: e,
    );
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) return 'Enter your password';
    if (password.length < 8) return 'At least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(password)) return 'Add an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(password)) return 'Add a lowercase letter';
    if (!RegExp(r'[0-9]').hasMatch(password)) return 'Add a number';
    return null;
  }
}
