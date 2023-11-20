import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonCardWidget extends StatelessWidget {
  String iconAsset;
  String namaButton;
  ButtonCardWidget({
    super.key,
    required this.iconAsset,
    required this.namaButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          onPressed: () {
            if (namaButton == 'Login') {
              Navigator.pushNamed(context, '/login');
            }
          },
          child: Row(
            children: [
              Image.asset(
                iconAsset,
                height: 25,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                namaButton,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
