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
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: HeaderWidget(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ProfilGedungWidget(),
                    ),
                    const PesanGedungWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 55,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 0),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: TextField(
                                // controller: searchController,
                                onChanged: (value) {
                                  // setState(() {
                                  //   isSearching = true;
                                  // });
                                  // filterAdzanList(value);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Cari Artikel',
                                  fillColor: Colors.white,
                                  filled: true,
                                  suffixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  // contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Artikel'),
                              Text(
                                'See All',
                                style: TextStyle(
                                  color: Color(0xFF3E70F2),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(15),
                            decoration:
                                const BoxDecoration(color: Colors.black12),
                            child: Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Website Resmi dari Gedung Triharjo..',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Website Resmi Gedung Triharjo..',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 800,
                    )
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
