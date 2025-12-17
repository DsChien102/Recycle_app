import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recycle_flutter/pages/google_map.dart';
import 'package:recycle_flutter/pages/home.dart';
import 'package:recycle_flutter/pages/points.dart';
import 'package:recycle_flutter/pages/profile.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home homePage;
  late Points points;
  late Profile profilePage;
  late GoogleMapFlutter googleMap;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    homePage = Home();
    points = Points();
    profilePage = Profile();
    googleMap = GoogleMapFlutter();

    pages = [homePage, points, googleMap, profilePage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.point_of_sale, size: 30, color: Colors.white),
          Icon(Icons.map, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
