import 'package:flutter/material.dart';
import 'package:jucang_app/pages/owner/home_page.dart';
import 'package:jucang_app/pages/owner/report_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerNavBar extends StatefulWidget {
  const OwnerNavBar({Key? key}) : super(key: key);

  @override
  State<OwnerNavBar> createState() => _OwnerNavBarState();
}

class _OwnerNavBarState extends State<OwnerNavBar> {
  late int _selectedPage;
  String? name;
  String? token;
  late SharedPreferences _prefs;

  late final List<Widget> _pages = <Widget> [
    OwnerHomePage(name!, token!),
    OwnerReportPage(bearer: token!),
  ];

  @override
  void initState() {
    setPrefs();
    _selectedPage = 0;
    super.initState();
  }

  Future<void> setPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('nama') ?? 'Unknown';
      token = _prefs.getString('token') ?? '';
    });
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
