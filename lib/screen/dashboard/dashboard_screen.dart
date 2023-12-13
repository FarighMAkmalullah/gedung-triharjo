import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/header_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/pesan_gedung_widget.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/profil_gedung_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F6),
        body: ListView(
          children: [
            Stack(
              children: [
                Container(
                  height: 160,
                  decoration: const BoxDecoration(
                      color: Color(0xFF3E70F2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      )),
                ),
                const Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: HeaderWidget(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ProfilGedungWidget(),
                    ),
                    PesanGedungWidget(),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
