import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/entities/product.dart';
import 'package:jucang_app/domain/helper/constant.dart';
import 'package:jucang_app/pages/sales/home_page.dart';

class InputDataImpl{
  static final _host = Uri.https(Helper.api, '/');

  Future<void> inputStuff(BuildContext context, String id, String nama, String alamat, Map<String, String> order, String status, String tanggal, String bearer) async {
    try {
      final response = await http.post(
        _host.replace(path: '/api/sales/mesan/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $bearer',
        },
        body: jsonEncode(<String, dynamic>{
          "nama_toko": nama,
          "alamat_toko": alamat,
          "tanggal": tanggal,
          "status": status,
          "return": "0",
          "terjual": "0",
          "sample": "0",
          "dataProduk": order,
        }),
      );

      if (response.statusCode == 200) {
        showSnackBar(context);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => HomePageSales()), (route) => false);
      } else {
        // Handle non-200 status codes here
        // You can throw a custom exception or handle the error accordingly
        throw Exception('Failed with status code ${response.statusCode}');
      }
    } on TimeoutException {
      throw TimeoutException('Request timed out');
    } catch (e) {
      // Handle other exceptions here, e.g., network errors, JSON decoding errors
      print('Error: $e');
      throw Exception('An error occurred');
    }
  }

  Future <List<Product>> getProduct () async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/produk/'),
        headers: <String, String> {},
      );
      if (response.statusCode == 200) {
        List o = jsonDecode(response.body);
        return o.map((e) => Product.fromJson(e)).toList();
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Success!!'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}