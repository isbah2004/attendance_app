import 'package:flutter/material.dart';

class Neomorphic1 extends StatefulWidget {
  const Neomorphic1({super.key});

  @override
  State<Neomorphic1> createState() => _Neomorphic1State();
}

class _Neomorphic1State extends State<Neomorphic1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: const Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1)
              ]),
          child: const Icon(Icons.apple),
        ),
      ),
    );
  }
}
