import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/usecases/updateData.dart';
import 'package:jucang_app/pages/sales/home_page.dart';

class SalesUpdatePage extends StatefulWidget {
  const SalesUpdatePage({
    Key? key,
    required this.name,
    required this.id,
    required this.id_user,
    required this.token,
    required this.status,
    required this.terjual,
    required this.kembali,
    required this.sample,
  }) : super(key: key);

  final String name;
  final String id;
  final String id_user;
  final String token;
  final int status;
  final int terjual;
  final int kembali;
  final int sample;

  @override
  State<SalesUpdatePage> createState() => _SalesUpdatePageState();
}

class _SalesUpdatePageState extends State<SalesUpdatePage> {
  final returnAmount = TextEditingController();
  final soldAmount = TextEditingController();
  final sampleAmount = TextEditingController();

  final update = UpdateDataImpl();

  @override
  void initState() {
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
        padding: const EdgeInsets.only(right: 15, left: 12, top: 50, bottom: 30),
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
                          Navigator.push(context, MaterialPageRoute(builder: (c) => HomePageSales()));
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
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  update.updateStuff(
                    context,
                    widget.name,
                    widget.id,
                    widget.status,
                    int.parse(returnAmount.text),
                    int.parse(soldAmount.text),
                    int.parse(sampleAmount.text),
                    widget.token,
                    widget.id_user,
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (x) => HomePageSales()));
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
