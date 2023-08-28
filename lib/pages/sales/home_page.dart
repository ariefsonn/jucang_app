import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/pages/sales/input_stuff_page.dart';

class HomePageSales extends StatefulWidget {
  const HomePageSales({Key? key}) : super(key: key);

  @override
  State<HomePageSales> createState() => _HomePageSalesState();
}

class _HomePageSalesState extends State<HomePageSales> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 60, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Selamat Datang,', style: textstyle.greetings_salute),
                Text('Aylmer', style: textstyle.greetings_salute),
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
            SizedBox(
              height: 634,
              child: TabBarView(
                controller: _tabController,
                children: <Widget> [
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 20,
                    itemBuilder: (BuildContext ctx, int i) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: Color(0xffececec),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Toko Bos Sawit', style: textstyle.style_namaToko),
                                  Text('6/8/2023', style: TextStyle(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            height: 3,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 5),
                        ],
                      );
                    },
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 30,
                    itemBuilder: (BuildContext ctx, int i) {
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 80,
                            decoration: const BoxDecoration(
                              color: const Color(0xffececec),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Toko Bos Sawit', style: textstyle.style_namaToko),
                                  Text('6/8/2023', style: TextStyle(color: Colors.black54)),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                            ),
                            height: 3,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 5),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => const InputStuffPage()), (route) => false);
        },
        tooltip: 'Input data',
        child: const Icon(Icons.add),
      ),
    );
  }
}
