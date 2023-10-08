import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/usecases/updateData.dart';
import 'package:jucang_app/pages/owner/sales_page.dart';

class OwnerUpdatePage extends StatefulWidget {
  const OwnerUpdatePage(this.name, this.id, this.id_user, this.token, {Key? key, required this.terjual, required this.kembali, required this.sample}) : super(key: key);

  final String name;
  final String id;
  final String id_user;
  final String token;
  final int terjual;
  final int kembali;
  final int sample;

  @override
  State<OwnerUpdatePage> createState() => _OwnerUpdatePageState();
}

class _OwnerUpdatePageState extends State<OwnerUpdatePage> with TickerProviderStateMixin {
  final returnAmount = TextEditingController();
  final soldAmount = TextEditingController();
  final sampleAmount = TextEditingController();

  final update = UpdateDataImpl();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    returnAmount.text = '${widget.kembali}';
    soldAmount.text = "${widget.terjual}";
    sampleAmount.text = "${widget.sample}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(right: 15, left: 15, top: 50, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => OwnerSalesPage(widget.id_user, widget.name, widget.token)), (route) => false);
                        },
                        child: const Icon(Icons.keyboard_arrow_left_rounded),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(widget.name, style: textstyle.greetings_salute),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Product: ', style: textstyle.style_titleinput),
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffececec),
                    // color: Colors.black54,
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Return',
                        ),
                        keyboardType: TextInputType.number,
                        controller: returnAmount,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Terjual',
                        ),
                        keyboardType: TextInputType.number,
                        controller: soldAmount,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Jumlah Sample',
                        ),
                        keyboardType: TextInputType.number,
                        controller: sampleAmount,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Status: ', style: textstyle.style_titleinput),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  padding: const EdgeInsets.only(top: 5,left: 8,right: 8,bottom: 5),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffececec)
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
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    tabs: const <Widget> [
                      Tab(text: 'Hutang'),
                      Tab(text: 'Lunas'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  print(_tabController.index);
                  update.updateStuffOwner(
                    context,
                    widget.name,
                    widget.id,
                    _tabController.index,
                    int.parse(returnAmount.text),
                    int.parse(soldAmount.text),
                    int.parse(sampleAmount.text),
                    widget.token,
                    widget.id_user,
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (c) => OwnerSalesPage(widget.id_user, widget.name, widget.token)));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF3C70E0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Euclid Circular B',
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
