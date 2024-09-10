import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class Neomorphic3 extends StatefulWidget {
  const Neomorphic3({super.key});

  @override
  State<Neomorphic3> createState() => _Neomorphic3State();
}

class _Neomorphic3State extends State<Neomorphic3> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    double blur = isPressed ? 10 : 20;
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(8, 8);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                  child: AnimatedContainer(
                    padding: const EdgeInsets.all(50),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              offset: distance,
                              blurRadius: blur,
                              inset: isPressed ? true : false),
                          BoxShadow(
                            color: Colors.white,
                            offset: -distance,
                            blurRadius: blur,
                            inset: isPressed ? true : false,
                          )
                        ]),
                    duration: const Duration(milliseconds: 100),
                    child: const Icon(Icons.apple),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey.shade900),
                child: AnimatedContainer(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: distance,
                            blurRadius: blur,
                            spreadRadius: 1,
                            inset: isPressed ? true : false),
                        BoxShadow(
                          color: Colors.grey.shade800,
                          offset: -distance,
                          inset: isPressed ? true : false,
                          blurRadius: blur,
                          spreadRadius: 1,
                        )
                      ]),
                  duration: const Duration(milliseconds: 100),
                  child: const Icon(Icons.apple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
