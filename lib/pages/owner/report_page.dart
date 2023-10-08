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
        hutangList = List<Map<String, dynamic>>.from(data);
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
                const DataColumn(label: Text('ID')),
                const DataColumn(label: Text('Nama User')),
                const DataColumn(label: Text('Nama Toko')),
                const DataColumn(label: Text('Alamat Toko')),
                const DataColumn(label: Text('Tanggal')),
                const DataColumn(label: Text('Total Harga')),
                const DataColumn(label: Text('Return')),
                const DataColumn(label: Text('Terjual')),
                const DataColumn(label: Text('Sample')),
                const DataColumn(label: Text('Status')),
                for (var product in getProductNames(hutangList))
                  DataColumn(label: Text(product)),
              ],
              rows: [
                for (var item in hutangList)
                  DataRow(
                    cells: [
                      DataCell(Text(item['id'].toString())),
                      DataCell(Text(item['user']['name'])),
                      DataCell(Text(item['nama_toko'])),
                      DataCell(Text(item['alamat_toko'])),
                      DataCell(Text(item['tanggal'])),
                      DataCell(Text(item['total_harga'])),
                      DataCell(Text(item['return'])),
                      DataCell(Text(item['terjual'])),
                      DataCell(Text(item['sample'])),
                      DataCell(Text(item['status'])),
                      for (var productName in getProductNames(hutangList))
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