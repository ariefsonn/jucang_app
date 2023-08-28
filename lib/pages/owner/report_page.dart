import 'package:flutter/material.dart';

class OwnerReportPage extends StatefulWidget {
  const OwnerReportPage({Key? key}) : super(key: key);

  @override
  State<OwnerReportPage> createState() => _OwnerReportPageState();
}

class _OwnerReportPageState extends State<OwnerReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            DataTable(
              columns: const [
                DataColumn(
                  label: Text('ID'),
                ),
                DataColumn(
                  label: Text('Nama Toko'),
                ),
                DataColumn(
                  label: Text('Alamat Toko'),
                ),
                DataColumn(
                  label: Text('Tanggal'),
                ),
                DataColumn(
                  label: Text('Milktea 330'),
                ),
                DataColumn(
                  label: Text('Milktea 250'),
                ),
                DataColumn(
                  label: Text('Vanila Tea'),
                ),
                DataColumn(
                  label: Text('Kacang Ijo'),
                ),
                DataColumn(
                  label: Text('Strawberry'),
                ),
                DataColumn(
                  label: Text('Matcha Latte'),
                ),
                DataColumn(
                  label: Text('Kedelai'),
                ),
                DataColumn(
                  label: Text('Kacang Merah'),
                ),
                DataColumn(
                  label: Text('Chocolate'),
                ),
                DataColumn(
                  label: Text('Mango'),
                ),
                DataColumn(
                  label: Text('Return'),
                ),
                DataColumn(
                  label: Text('Terjual'),
                ),
                DataColumn(
                  label: Text('Sample'),
                ),
                DataColumn(
                  label: Text('Status'),
                ),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
                DataRow(cells: [
                  DataCell(Text('1')),
                  DataCell(Text('SI Mart')),
                  DataCell(Text('QBS')),
                  DataCell(Text('2023-04-03')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('1')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('0')),
                  DataCell(Text('Hutang')),
                ]),
              ],
            ),
          ],
        )
      ),
    );
  }
}
