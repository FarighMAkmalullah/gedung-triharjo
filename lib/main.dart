import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/onboarding/onboarding_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/splash_screen/splash_screen.dart';

void main() {
  runApp(
    const GedungTriharjo(),
  );
}

class GedungTriharjo extends StatelessWidget {
  const GedungTriharjo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
      },
    );
  }
}
