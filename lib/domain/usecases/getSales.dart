import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/entities/sales.dart';
import 'package:jucang_app/domain/helper/constant.dart';

class GetSalesImpl {
  static final _host = Uri.https(Helper.api, '/');

  Future <List<Sales>>  getSales (String bearer) async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/owner/'),
        headers: <String, String> {
          'Authorization' : 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        List o = jsonDecode(response.body)['S'];
        return o.map((e) => Sales.fromJson(e)).toList();
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
}