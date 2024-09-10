import 'package:flutter/material.dart';

class Neomorphic2 extends StatefulWidget {
  const Neomorphic2({super.key});

  @override
  State<Neomorphic2> createState() => _Neomorphic2State();
}

class _Neomorphic2State extends State<Neomorphic2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1),
                BoxShadow(
                    color: Colors.grey.shade800,
                    offset: const Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1)
              ]),
          child: const Icon(Icons.apple),
        ),
      ),
    );
  }
}
