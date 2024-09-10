import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class NeumorphicWidget extends StatelessWidget {
  final double? height, width;
  final Widget child;
  final BoxShape? boxShape;
  const NeumorphicWidget(
      {super.key, required this.child, this.height, this.width, this.boxShape});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          shape: boxShape?? BoxShape.rectangle,
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
        child: child);
  }
}
