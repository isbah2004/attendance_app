import 'package:another_flushbar/flushbar.dart';
import 'package:attendance_app/theme/light_mode.dart';
import 'package:flutter/material.dart';

class Utils {
  static void changeFocus(
      {required FocusNode currentFocus,
      required FocusNode nextFocus,
      required BuildContext context}) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

static void showCustomFlushbar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  IconData? icon,
  FlushbarPosition position = FlushbarPosition.BOTTOM,
  Duration duration = const Duration(seconds: 3),
}) {
  final ThemeData theme = LightMode.lightTheme;

  Flushbar(
    messageText: Text(
      message,
      style: TextStyle(color: theme.colorScheme.inversePrimary),
    ),
    duration: duration,
    backgroundColor: backgroundColor ?? theme.colorScheme.primary,
    flushbarPosition: position,
    icon: Icon(
      icon ?? Icons.info_outline,
      color: theme.colorScheme.inversePrimary,
    ),
    shouldIconPulse: true,
  ).show(context);
}

static  void showSuccessFlushbar( {required context,required String message}) {
    Utils.showCustomFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
    
  }
  static void showErrorFlushbar({required context,required  String message,required e}){
        Utils.showCustomFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
    debugPrint(e.toString());
  }

  }

