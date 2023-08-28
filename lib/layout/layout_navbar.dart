import 'package:flutter/material.dart';
import 'package:jucang_app/pages/owner/home_page.dart';
import 'package:jucang_app/pages/owner/report_page.dart';

class OwnerNavBar extends StatefulWidget {
  const OwnerNavBar({Key? key}) : super(key: key);

  @override
  State<OwnerNavBar> createState() => _OwnerNavBarState();
}

class _OwnerNavBarState extends State<OwnerNavBar> {
  late int _selectedPage;

  late final List<Widget> _pages = <Widget> [
    const OwnerHomePage(),
    const OwnerReportPage(),
  ];

  @override
  void initState() {
    _selectedPage = 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedPage),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
        elevation: 0,
        iconSize: 29,
        showUnselectedLabels: true,
        selectedItemColor: const Color(0xFF1865B7),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        items: const  <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_rounded),
            label: 'Report',
          ),
        ],
      ),
    );
  }
}
