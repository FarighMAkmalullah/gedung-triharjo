import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/widget/header_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _pageController = PageController();
  List<String> imageUrls = [
    "assets/image/dashboard/dashboard1.jpg",
    "assets/image/dashboard/dashboard2.jpg",
    "assets/image/dashboard/dashboard3.jpg",
  ];
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  child: Column(
                    children: [
                      const HeaderWidget(),
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: PageView(
                              controller: _pageController,
                              children: imageUrls.map(
                                (imageUrl) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      height: 150,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Aplikasi Gedung Triharjo",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SmoothPageIndicator(
                                      controller: _pageController,
                                      count: imageUrls.length,
                                      effect: SlideEffect(
                                        activeDotColor: Colors.white,
                                        dotHeight: 8,
                                        dotWidth: 8,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
