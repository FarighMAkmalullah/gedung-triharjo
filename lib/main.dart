import 'package:flutter/material.dart';

void main() {
  runApp(
    const GedungTriharjo(),
  );
}

class GedungTriharjo extends StatelessWidget {
  const GedungTriharjo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF4472EB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'GTR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                ),
              ),
              Text(
                'Gedung Triharjo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
