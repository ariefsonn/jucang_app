import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jucang_app/domain/entities/order.dart';
import 'package:jucang_app/domain/helper/constant.dart';

class OrderListImpl{
  static final _host = Uri.https(Helper.api, '/');

  Future <List<Order>> OrderHutang (String id, String bearer) async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/sales/pesanan/$id'),
        headers: <String, String> {
          'Authorization' : 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        List o = jsonDecode(response.body)['Hutang'];
        return o.map((e) => Order.fromJson(e)).toList();
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future <List<Order>> OrderLunas (String id, String bearer) async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/sales/pesanan/$id'),
        headers: <String, String> {
          'Authorization' : 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        List o = jsonDecode(response.body)['Lunas'];
        return o.map((e) => Order.fromJson(e)).toList();
      }
    } on TimeoutException {
      throw TimeoutException('');
    }
    throw Exception();
  }
  Future<List<DataRow>> fetchTabelLunas(String id, String bearer, int id_pesanan) async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/sales/pesanan/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['Lunas'];

        // Filter the data to find the object with id equal to 1
        final Map<String, dynamic>? targetObject = data.firstWhere(
              (pesanan) => pesanan['id'] == id_pesanan,
          orElse: () => null,
        );

        if (targetObject != null) {
          final List<dynamic> produks = targetObject['produks'];
          final List<DataRow> dataRows = [];

          for (var produk in produks) {
            dataRows.add(DataRow(
              cells: [
                DataCell(Text(produk['nama_produk'])),
                DataCell(Text(produk['amount'].toString())),
              ],
            ));
          }

          return dataRows;
        }
      }
    } on TimeoutException {
      throw TimeoutException('');
    } catch (e) {
      throw Exception('Failed to load data from API');
    }

    throw Exception('Object with id 1 not found in the API response');
  }
  Future<List<DataRow>> fetchTabelHutang(String id, String bearer, int id_pesanan) async {
    try {
      final response = await http.get(
        _host.replace(path: '/api/sales/pesanan/$id'),
        headers: <String, String>{
          'Authorization': 'Bearer $bearer',
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['Hutang'];

        // Filter the data to find the object with id equal to 1
        final Map<String, dynamic>? targetObject = data.firstWhere(
              (pesanan) => pesanan['id'] == id_pesanan,
          orElse: () => null,
        );

        if (targetObject != null) {
          final List<dynamic> produks = targetObject['produks'];
          final List<DataRow> dataRows = [];

          for (var produk in produks) {
            dataRows.add(DataRow(
              cells: [
                DataCell(Text(produk['nama_produk'])),
                DataCell(Text(produk['amount'].toString())),
              ],
            ));
          }

          return dataRows;
        }
      }
    } on TimeoutException {
      throw TimeoutException('');
    } catch (e) {
      throw Exception('Failed to load data from API');
    }

    throw Exception('Object with id 1 not found in the API response');
  }
}