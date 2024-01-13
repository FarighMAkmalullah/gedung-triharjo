import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrorWidgetScreen extends StatefulWidget {
  final VoidCallback onRefreshPressed;
  const ErrorWidgetScreen({super.key, required this.onRefreshPressed});

  @override
  State<ErrorWidgetScreen> createState() => _ErrorWidgetState();
}

class _ErrorWidgetState extends State<ErrorWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            'ERROR',
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Text('Maaf sepertinya ada kesalahan'),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          onPressed: widget.onRefreshPressed,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Coba Lagi'),
          ),
        )
      ],
    );
  }
}
