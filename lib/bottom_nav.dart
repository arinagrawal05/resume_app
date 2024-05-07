import 'package:bottom_navbar_with_indicator/bottom_navbar_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pryka_labs/homescreen.dart';
import 'package:pryka_labs/spare_screen.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 3; //default index

  final List<Widget> _widgetOptions = [
    const SparePage(pagename: "Home"),
    const SparePage(pagename: "Search"),
    const SparePage(pagename: "Notes"),
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: false,
        lineIndicatorWidth: 3,

        indicatorType: IndicatorType.top,
        // gradient: LinearGradient(
        //   colors: kGradients,
        // ),

        customBottomBarItems: [
          customItem("assets/icons/bottom_home.png"),
          customItem("assets/icons/bottom_search.png"),
          customItem("assets/icons/bottom_note.png"),
          customItem("assets/icons/bottom_profile.png"),
        ],
      ),
    );
  }

  CustomBottomBarItems customItem(String assetUrl) {
    return CustomBottomBarItems(
      label: 'Loyalty',
      icon: Column(
        children: [
          Container(
            height: 40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                assetUrl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
