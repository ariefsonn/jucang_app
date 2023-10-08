import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:jucang_app/domain/entities/product.dart';
import 'package:jucang_app/domain/usecases/inputData.dart';
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
  final amountController = TextEditingController();

  Map<String, String> amountOrder = {};
  int totalProduct = 0;

  final update = UpdateDataImpl();
  final input = InputDataImpl();
  late Future<List<Product>> produk;

  @override
  void initState() {
    returnAmount.text = '${widget.kembali}';
    soldAmount.text = "${widget.terjual}";
    sampleAmount.text = "${widget.sample}";
    produk = input.getProduct();
    super.initState();
  }

  void addAmount(String id, String amount) {
    setState(() {
      amountOrder[id] = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    AlertDialog customAlertDialog({
      required BuildContext context,
      required String idProduk,
      required String namaProduk,
      required String harga,
    }) {
      return AlertDialog(
        title: Text('Produk: $namaProduk', style: textstyle.style_namaToko),
        content: SizedBox(
          height: 48, // Specify the desired height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Jumlah Pesanan',
                ),
                keyboardType: TextInputType.number,
                controller: amountController,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              addAmount(idProduk, amountController.text);
              Navigator.pop(context, 'Submit');
              totalProduct += int.parse(amountController.text) * int.parse(harga);
              amountController.text = '';
            },
            child: const Text('Submit'),
          ),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(right: 15, left: 12, top: 50, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
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
                    margin: const EdgeInsets.only(bottom: 30),
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const SizedBox(height: 20),
                        const Text('Produk: ', style: textstyle.style_titleinput),
                        const SizedBox(height: 15),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: FutureBuilder(
                              future: produk,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, int i) {
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        width: double.infinity,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: const Color(0xffececec),
                                          // color: Colors.black54,
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget> [
                                            SizedBox(
                                              width: 190,
                                              child: Text(snapshot.data![i].name, style: textstyle.style_namaToko, overflow: TextOverflow.ellipsis),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(context: context, builder: (BuildContext ctx) => customAlertDialog(
                                                  context: context,
                                                  idProduk: snapshot.data![i].id.toString(),
                                                  namaProduk: snapshot.data![i].name,
                                                  harga: snapshot.data![i].price,
                                                ));
                                              },
                                              child: const Text('TAMBAH', style: textstyle.style_update),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text('There is nothing to showed'));
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
                ],
              ),
            ),
            Column(
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
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Harga: ", style: textstyle.greetings_salute),
                      Text(NumberFormat.simpleCurrency(name: "IDR").format(totalProduct), style: textstyle.greetings_salute),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      update.updateStuffSales(
                        context,
                        widget.name,
                        widget.id,
                        widget.status,
                        int.parse(returnAmount.text),
                        int.parse(soldAmount.text),
                        int.parse(sampleAmount.text),
                        widget.token,
                        widget.id_user,
                        amountOrder,
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
            )
          ],
        ),
      ),
    );
  }
}
