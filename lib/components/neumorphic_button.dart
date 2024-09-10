import 'package:attendance_app/constants/constants.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:lottie/lottie.dart';

class NeumorphicButton extends StatelessWidget {
  final Widget child;
  final double? height;
  final VoidCallback onTap;
  final bool isLoading;
  const NeumorphicButton(
      {super.key, this.height, required this.onTap, required this.isLoading, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: height ?? 45,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                inset: isLoading,
                offset: const Offset(5, 5),
                blurRadius: 10,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4)),
            BoxShadow(
                inset: isLoading,
                offset: Offset(-5, -5),
                blurRadius: 10,
                color: Colors.white60),
          ],
        ),
        alignment: Alignment.center,
        duration: Duration(milliseconds: 100),
        child: isLoading ? Lottie.asset(Constants.loadingAnimation) : child,
      ),
    );
  }
}
