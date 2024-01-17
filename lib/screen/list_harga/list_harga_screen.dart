import 'package:flutter/material.dart';

class ListHargaScreen extends StatefulWidget {
  const ListHargaScreen({super.key});

  @override
  State<ListHargaScreen> createState() => _ListHargaScreenState();
}

class _ListHargaScreenState extends State<ListHargaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History Order',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF3E70F2),
      ),
    );
  }
}
