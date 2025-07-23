import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:recycle_me/pages/points.dart';
import 'package:recycle_me/pages/profile.dart';
import 'package:recycle_me/pages/home.dart';

import 'check_item.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;
  late Home HomePage;
  late CheckItem CameraPage;
  late Points points;

  int currentIndex = 0;

  @override
  void initState() {
    HomePage = Home();
    points = Points();
    CameraPage= CheckItem();

    pages = [HomePage, points, CameraPage];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 70,
          backgroundColor: Colors.white,
          color: Colors.green,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index){
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            Icon(Icons.home, color: Colors.white, size: 34.0,),
            Icon(Icons.point_of_sale, color: Colors.white, size: 34.0,),
            Icon(Icons.person, color: Colors.white, size: 34.0,),
          ]
      ),
      body: pages[currentIndex],
    );
  }
}


