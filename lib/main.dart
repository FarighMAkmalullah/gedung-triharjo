import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/bottom_bar/bottom_bar.dart';
import 'package:penyewaan_gedung_triharjo/screen/login/login_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/onboarding/onboarding_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/register/register_screen.dart';
// import 'package:penyewaan_gedung_triharjo/screen/splash_screen/splash_screen.dart';

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
        '/': (context) => const BottomBar(indexPage: 0),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
