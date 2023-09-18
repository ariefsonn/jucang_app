import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/helper/constant.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';

class UpdateDataImpl {
  static final _host = Uri.https(Helper.api, '/');

  Future<void> updateStuff(BuildContext context, String name, String id, int status, int kembali, int sold, int sample, String bearer, String id_user) async {
    try {
      final response = await http.post(
        _host.replace(path: '/api/sales/update/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization' : 'Bearer $bearer',
        },
        body: jsonEncode(<String, dynamic>{
          "status" : status,
          "return" : kembali,
          "terjual" : sold,
          "sample" : sample,
        }),
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
      content: Text('Successfully updated'),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
