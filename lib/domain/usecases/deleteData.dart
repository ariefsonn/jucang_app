import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/helper/constant.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';

class DeleteDataImpl {
  static final _host = Uri.https(Helper.api, '/');

  Future<void> deleteStuff(BuildContext context, String bearer, String id) async {
    try {
      final response = await http.post(
        _host.replace(path: '/api/sales/delete/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        showSnackBar(context);
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Successfully deleted'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}