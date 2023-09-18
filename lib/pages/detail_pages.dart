import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/usecases/orderList.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';
import 'package:jucang_app/pages/sales/home_page.dart';
import 'package:intl/intl.dart';

class DetailPesananPage extends StatefulWidget {
  const DetailPesananPage({
    Key? key,
    required this.name,
    required this.id_user,
    required this.bearer,
    required this.backTo,
    required this.id_pesanan,
    required this.status,
    required this.nama_toko,
    required this.tanggal,
    required this.kembali,
    required this.terjual,
    required this.sample,
    required this.harga,
  }) : super(key: key);

  final String name; // nama toko
  final String id_user;
  final String bearer;
  final bool backTo; // true = owner, false = sales
  final String id_pesanan;
  final bool status; // true = lunas, false = hutang

  final String nama_toko;
  final String tanggal;
  final String kembali;
  final String terjual;
  final String sample;
  final String harga;

  @override
  State<DetailPesananPage> createState() => _DetailPesananPageState();
}

class _DetailPesananPageState extends State<DetailPesananPage> {
  final order = OrderListImpl();
  late Future<List<DataRow>> rowL;
  late Future<List<DataRow>> rowH;

  @override
  void initState() {
    rowL = order.fetchTabelLunas(widget.id_user, widget.bearer, int.parse(widget.id_pesanan));
    rowH = order.fetchTabelHutang(widget.id_user, widget.bearer, int.parse(widget.id_pesanan));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffececec),
                // color: Colors.black54,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => widget.backTo ? OwnerSalesPage(widget.id_user, widget.name, widget.bearer) : const HomePageSales()), (route) => false);
                    },
                    child: const Icon(Icons.keyboard_arrow_left_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(widget.nama_toko, style: textstyle.greetings_salute),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('Pesanan: ', style: textstyle.style_titleinput),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffececec),
                // color: Colors.black54,
              ),
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Sales:  ${widget.name}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Tanggal:  ${widget.tanggal}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Status:  ${widget.status ? 'Lunas' : 'Hutang'}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Kembali:  ${widget.kembali}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Terjual:  ${widget.terjual}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Sample:  ${widget.sample}', style: textstyle.style_namaToko),
                  const SizedBox(height: 10),
                  Text('Total Harga:  ${NumberFormat.simpleCurrency(name: 'IDR').format(int.parse(widget.harga))}', style: textstyle.style_namaToko),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('Produk: ', style: textstyle.style_titleinput),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  FutureBuilder(
                  future: widget.status ? rowL : rowH,
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Expanded(child: DataTable(
                            columns: const [
                              DataColumn(
                                label: Text('Nama Produk', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              DataColumn(
                                label: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                            rows: snapshot.data!,
                          )),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Nothing to be Showed'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
