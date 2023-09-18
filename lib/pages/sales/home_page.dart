import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/entities/order.dart';
import 'package:jucang_app/domain/usecases/deleteData.dart';
import 'package:jucang_app/domain/usecases/orderList.dart';
import 'package:jucang_app/domain/usecases/updateData.dart';
import 'package:jucang_app/pages/detail_pages.dart';
import 'package:jucang_app/pages/login_page.dart';
import 'package:jucang_app/pages/sales/input_stuff_page.dart';
import 'package:jucang_app/pages/sales/update_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageSales extends StatefulWidget {
  const HomePageSales({Key? key}) : super(key: key);

  @override
  State<HomePageSales> createState() => _HomePageSalesState();
}

class _HomePageSalesState extends State<HomePageSales> with TickerProviderStateMixin {
  late SharedPreferences _prefs;
  String? name;
  String? token;
  String? bearer;

  final order = OrderListImpl();
  final delete = DeleteDataImpl();
  final update = UpdateDataImpl();

  late Future<List<Order>> hu;
  late Future<List<Order>> lu;

  Future<void> setPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      name = _prefs.getString('nama') ?? 'Unknown';
      token = _prefs.getString('id') ?? '';
      bearer = _prefs.getString('token') ?? '';
    });
    hu = order.OrderHutang(token!, bearer!);
    lu = order.OrderLunas(token!, bearer!);
  }

  @override
  void initState() {
    setPrefs();
    super.initState();
  }

  AlertDialog showLogoutDialog() {
    return AlertDialog(
      title: const Text('Want to logout?', style: textstyle.style_namaToko),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() async {
              _prefs = await SharedPreferences.getInstance();
              _prefs.remove('id');
              _prefs.remove('nama');
              _prefs.remove('no_hp');
              _prefs.remove('tipe');
              _prefs.remove('token');
              _prefs.setBool('is_login', false);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => LoginPage()));
            });
          },
          child: const Text('Submit'),
        ),
      ],
    );
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
            delete.deleteStuff(ctx, bearer!, id);
            Navigator.push(context, MaterialPageRoute(builder: (c) => HomePageSales()));
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
                    const Text('Selamat Datang,', style: textstyle.greetings_salute),
                    Text(name!, style: textstyle.greetings_salute),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (c) => showLogoutDialog());
                  },
                  child: const Icon(Icons.logout_rounded, size: 30),
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
                                    name: name!,
                                    id_user: token!,
                                    bearer: bearer!,
                                    backTo: false,
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
                                      height: 95,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffececec),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          )
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
                                                Text(snapshot.data![i].tanggal, style: TextStyle(color: Colors.black54)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showDialog(context: context, builder: (BuildContext c) =>  showDeleteDialog(ctx: context, id: snapshot.data![i].id.toString()));
                                                    });
                                                  },
                                                  child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 25),
                                                ),
                                                const SizedBox(height: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (c) => SalesUpdatePage(
                                                      name: snapshot.data![i].nama_toko,
                                                      id: snapshot.data![i].id.toString(),
                                                      id_user: token!,
                                                      token: bearer!,
                                                      status: 1,
                                                      terjual: int.parse(snapshot.data![i].terjual),
                                                      kembali: int.parse(snapshot.data![i].kembali),
                                                      sample: int.parse(snapshot.data![i].sample),
                                                    )));
                                                  },
                                                  child: Icon(Icons.update_rounded, color: Colors.green[600], size: 25),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      height: 5,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Nothing to be showed'));
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
                                    name: name!,
                                    id_user: token!,
                                    bearer: bearer!,
                                    backTo: false,
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
                                      height: 95,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffececec),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        ),
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
                                                Text(snapshot.data![i].tanggal, style: TextStyle(color: Colors.black54)),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showDialog(context: context, builder: (BuildContext c) =>  showDeleteDialog(ctx: context, id: snapshot.data![i].id.toString()));
                                                    });
                                                  },
                                                  child: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 25),
                                                ),
                                                const SizedBox(height: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (c) => SalesUpdatePage(
                                                      name: snapshot.data![i].nama_toko,
                                                      id: snapshot.data![i].id.toString(),
                                                      id_user: token!,
                                                      token: bearer!,
                                                      status: 0,
                                                      terjual: int.parse(snapshot.data![i].terjual),
                                                      kembali: int.parse(snapshot.data![i].kembali),
                                                      sample: int.parse(snapshot.data![i].sample),
                                                    )));
                                                  },
                                                  child: Icon(Icons.update_rounded, color: Colors.green[600], size: 25),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      height: 5,
                                      width: double.infinity,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(child: Text('Nothing to be showed'));
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => InputStuffPage(name!, token!, bearer!)), (route) => false);
        },
        tooltip: 'Input data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
