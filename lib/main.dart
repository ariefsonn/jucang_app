import 'package:flutter/material.dart';
import 'package:jucang_app/layout/layout_navbar.dart';
import 'package:jucang_app/pages/detail_pages.dart';
import 'package:jucang_app/pages/login_page.dart';
import 'package:jucang_app/pages/owner/home_page.dart';
import 'package:jucang_app/pages/owner/report_page.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';
import 'package:jucang_app/pages/owner/update_page.dart';
import 'package:jucang_app/pages/sales/home_page.dart';
import 'package:jucang_app/pages/sales/input_stuff_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
