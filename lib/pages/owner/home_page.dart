import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/entities/sales.dart';
import 'package:jucang_app/domain/usecases/getSales.dart';
import 'package:jucang_app/pages/login_page.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage(this.name, this.token, {Key? key}) : super(key: key);

  final String token;
  final String? name;

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  late SharedPreferences _prefs;
  final sales = GetSalesImpl();

  late Future<List<Sales>> s;

  @override
  void initState() {
    s = sales.getSales(widget.token);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Container(
              height: 78,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xffececec),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Selamat Datang,', style: textstyle.greetings_salute),
                      Text(widget.name!, style: textstyle.greetings_name),
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
            ),
            const SizedBox(height: 50),
            const Text('Sales: ', style: textstyle.style_titleinput),
            const SizedBox(height: 15),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: FutureBuilder(
                  future: s,
                  builder: (c, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (ctx) => OwnerSalesPage(snapshot.data![i].id.toString(), snapshot.data![i].name, widget.token)));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffececec),
                                // color: Colors.black54,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget> [
                                  Text(snapshot.data![i].name, style: textstyle.style_namaToko),
                                ],
                              ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
