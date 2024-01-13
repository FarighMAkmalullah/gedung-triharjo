import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penyewaan_gedung_triharjo/credential/supabase_credential.dart';
import 'package:penyewaan_gedung_triharjo/screen/bottom_bar/bottom_bar.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/list_event_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pembayaran/detail_pembayaran_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/detail_pemesanan_berhasil/detail_pemesanan_berhasil_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/login/login_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/onboarding/onboarding_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/provil_view_model.dart';
import 'package:penyewaan_gedung_triharjo/screen/register/register_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:penyewaan_gedung_triharjo/screen/splash_screen/splash_screen.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfilViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EventViewModel(),
        ),
      ],
      child: const GedungTriharjo(),
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
}

class GedungTriharjo extends StatelessWidget {
  const GedungTriharjo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/bottom_bar': (context) => const BottomBar(indexPage: 0),
      },
    );
  }
}
