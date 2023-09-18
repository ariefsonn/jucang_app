import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/helper/constant.dart';
import 'package:jucang_app/layout/layout_navbar.dart';
import 'package:jucang_app/pages/sales/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationImpl {
  static final _host = Uri.https(Helper.api, '/');
  late SharedPreferences preferences;
  late SharedPreferences _check;

  Future<void> authenticate(String name, String password, BuildContext ctx) async {
    try {
      final response = await http.post(
        _host.replace(path: '/api/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        var o = jsonDecode(response.body);
        var token = o['token'];
        var user = o['user'];
        saveSession(user['id'], user['name'], user['no_tlp'], user['tipe'], token, ctx);
      } else if (response.statusCode == 401) {
        showSnackBar(ctx);
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  void saveSession(id, name, phone, type, token, BuildContext ctx) async {
    preferences = await SharedPreferences.getInstance();
    preferences.setString('id', id.toString());
    preferences.setString('nama', name.toString());
    preferences.setString('no_hp', phone.toString());
    preferences.setString('tipe', type.toString());
    preferences.setString('token', token.toString());
    preferences.setBool('is_login', true);

    if (type == 'S') {
      Navigator.of(ctx).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const HomePageSales()),
              (route) => false);
    } else if (type == 'A') {
      Navigator.of(ctx).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => const OwnerNavBar()),
              (route) => false);
    } else {
      null;
    }
  }
  void checkLogin(BuildContext ctx) async {
    _check = await SharedPreferences.getInstance();
    var isLogin = _check.getBool('is_login');
    var type = _check.getString('tipe');

    if (isLogin != null && isLogin) {
      if (type == 'S') {
        Navigator.of(ctx).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomePageSales()),
                (route) => false);
      } else if (type == 'A') {
        Navigator.of(ctx).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const OwnerNavBar()),
                (route) => false);
      } else {
        null;
      }
    }
  }
  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Invalid Username or Password'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}