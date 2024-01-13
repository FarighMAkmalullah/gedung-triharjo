import 'package:flutter/material.dart';
import 'package:penyewaan_gedung_triharjo/screen/dashboard/dashboard_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/history/history_screen.dart';
import 'package:penyewaan_gedung_triharjo/screen/profil/profil_screen.dart';

class BottomBar extends StatefulWidget {
  final int indexPage;
  const BottomBar({
    super.key,
    required this.indexPage,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.indexPage;
  }

  List<Widget> children = [
    const DashboardScreen(),
    const HistoryScreen(),
    const ProfilScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> listAssets = [
    "assets/icon/bottom_bar/home.png",
    "assets/icon/bottom_bar/history.png",
    "assets/icon/bottom_bar/user.png",
    "assets/icon/bottom_bar/home_selected.png",
    "assets/icon/bottom_bar/history_selected.png",
    "assets/icon/bottom_bar/user_selected.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: currentIndex,
        children: children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color(0xFF3E70F2),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFC7C6CA),
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF3E70F2),
        ),
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 0 ? listAssets[3] : listAssets[0],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 1 ? listAssets[4] : listAssets[1],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 2 ? listAssets[5] : listAssets[2],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
