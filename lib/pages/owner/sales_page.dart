import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/entities/order.dart';
import 'package:jucang_app/domain/usecases/deleteData.dart';
import 'package:jucang_app/domain/usecases/orderList.dart';
import 'package:jucang_app/layout/layout_navbar.dart';
import 'package:jucang_app/pages/detail_pages.dart';
import 'package:jucang_app/pages/owner/update_page.dart';

class OwnerSalesPage extends StatefulWidget {
  const OwnerSalesPage(this.id_user, this.name, this.token, {Key? key}) : super(key: key);

   final String? id_user;
   final String? name;
   final String token;

  @override
  State<OwnerSalesPage> createState() => _OwnerSalesPageState();
}

class _OwnerSalesPageState extends State<OwnerSalesPage> with TickerProviderStateMixin {
  final order = OrderListImpl();
  final delete = DeleteDataImpl();
  late Future<List<Order>> hu;
  late Future<List<Order>> lu;

  @override
  void initState() {
    hu = order.OrderHutang(widget.id_user!, widget.token);
    lu = order.OrderLunas(widget.id_user!, widget.token);
    super.initState();
  }

  AlertDialog showDeleteDialog({
    required BuildContext ctx,
    required String id,
  }) {
    return AlertDialog(
      title: const Text('Are you sure to delete this?', style: textstyle.style_namaToko),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            delete.deleteStuff(ctx, widget.token, id);
            Navigator.push(context, MaterialPageRoute(builder: (c) => OwnerSalesPage(widget.id_user, widget.name, widget.token)));
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 60, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nama Sales:', style: textstyle.style_namaToko),
                    Text(widget.name!, style: textstyle.greetings_salute),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => const OwnerNavBar()));
                  },
                  child: const Icon(Icons.chevron_left_rounded, size: 30),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 20),
              padding: const EdgeInsets.only(top: 5,left: 8,right: 8,bottom: 5),
              width: double.infinity,
              height: 41,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xffececec)
              ),
              child: TabBar(
                controller: _tabController,
                unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500),
                unselectedLabelColor: const Color(0xffb2a9a9),
                labelStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w500),
                indicator: BoxDecoration(
                  color: Color(0xff5258d4),
                  borderRadius: BorderRadius.circular(7),
                ),
                tabs: const <Widget> [
                  Tab(text: 'Lunas',),
                  Tab(text: 'Hutang',),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget> [
                    FutureBuilder(
                      future: lu,
                      builder: (c, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPesananPage(
                                    name: widget.name!,
                                    id_user: widget.id_user!,
                                    bearer: widget.token,
                                    backTo: true,
                                    id_pesanan: snapshot.data![i].id.toString(),
                                    status: true,
                                    nama_toko: snapshot.data![i].nama_toko,
                                    tanggal: snapshot.data![i].tanggal,
                                    kembali: snapshot.data![i].kembali,
                                    terjual: snapshot.data![i].terjual,
                                    sample: snapshot.data![i].sample,
                                    harga: snapshot.data![i].price,
                                  )));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffececec),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(snapshot.data![i].nama_toko, style: textstyle.style_namaToko),
                                                Text(snapshot.data![i].tanggal, style: const TextStyle(color: Colors.black54)),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  showDialog(context: context, builder: (BuildContext c) =>  showDeleteDialog(ctx: context, id: snapshot.data![i].id.toString()));
                                                });
                                              },
                                              child: const Text('DELETE', style: textstyle.style_delete),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                      ),
                                      height: 5,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Nothing to be Showed'));
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                    FutureBuilder(
                      future: hu,
                      builder: (c, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, int i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (c) => DetailPesananPage(
                                    name: widget.name!,
                                    id_user: widget.id_user!,
                                    bearer: widget.token,
                                    backTo: true,
                                    id_pesanan: snapshot.data![i].id.toString(),
                                    status: false,
                                    nama_toko: snapshot.data![i].nama_toko,
                                    tanggal: snapshot.data![i].tanggal,
                                    kembali: snapshot.data![i].kembali,
                                    terjual: snapshot.data![i].terjual,
                                    sample: snapshot.data![i].sample,
                                    harga: snapshot.data![i].price,
                                  )));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffececec),
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(snapshot.data![i].nama_toko, style: textstyle.style_namaToko),
                                                Text(snapshot.data![i].tanggal, style: const TextStyle(color: Colors.black54)),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (ctx) => OwnerUpdatePage(
                                                  widget.name!,
                                                  snapshot.data![i].id.toString(),
                                                  widget.id_user!,
                                                  widget.token,
                                                  terjual: int.parse(snapshot.data![i].terjual),
                                                  kembali: int.parse(snapshot.data![i].kembali),
                                                  sample: int.parse(snapshot.data![i].sample),
                                                )));
                                              },
                                              child: const Text('UPDATE', style: textstyle.style_update),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                                      ),
                                      height: 5,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 6),
                                  ],
                                ),
                              );
                            },
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
            ),
          ],
        ),
      ),
    );
  }
}
