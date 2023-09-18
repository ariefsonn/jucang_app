import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jucang_app/domain/helper/constant.dart';

class OwnerReportPage extends StatefulWidget {
  const OwnerReportPage({required this.bearer, Key? key}) : super(key: key);

  final String bearer;

  @override
  State<OwnerReportPage> createState() => _OwnerReportPageState();
}

class _OwnerReportPageState extends State<OwnerReportPage> {
  List<Map<String, dynamic>> hutangList = [];
  List<Map<String, dynamic>> lunasList = [];

  static final _host = Uri.https(Helper.api, '/');

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      _host.replace(path: '/api/owner/all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer ${widget.bearer}',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        hutangList = List<Map<String, dynamic>>.from(data['Hutang']);
        lunasList = List<Map<String, dynamic>>.from(data['Lunas']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nama Toko')),
                DataColumn(label: Text('Alamat Toko')),
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Total Harga')),
                DataColumn(label: Text('Return')),
                DataColumn(label: Text('Terjual')),
                DataColumn(label: Text('Sample')),
                DataColumn(label: Text('Status')),
                for (var product in getProductNames(hutangList + lunasList))
                  DataColumn(label: Text(product)),
              ],
              rows: [
                for (var item in hutangList + lunasList)
                  DataRow(
                    cells: [
                      DataCell(Text(item['id'].toString())),
                      DataCell(Text(item['nama_toko'])),
                      DataCell(Text(item['alamat_toko'])),
                      DataCell(Text(item['tanggal'])),
                      DataCell(Text(item['total_harga'])),
                      DataCell(Text(item['return'])),
                      DataCell(Text(item['terjual'])),
                      DataCell(Text(item['sample'])),
                      DataCell(Text(item['status'])),
                      for (var productName in getProductNames(hutangList + lunasList))
                        DataCell(Text(getProductAmount(item, productName))),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> getProductNames(List<Map<String, dynamic>> dataList) {
    Set<String> productNames = Set<String>();

    for (var item in dataList) {
      for (var product in item['produks']) {
        productNames.add(product['nama_produk']);
      }
    }

    return productNames.toList();
  }

  String getProductAmount(Map<String, dynamic> item, String productName) {
    var product = item['produks'].firstWhere(
          (product) => product['nama_produk'] == productName,
      orElse: () => {'amount': '0'},
    );

    return product['amount'];
  }
}
