import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:intl/intl.dart';
import 'package:jucang_app/domain/entities/product.dart';
import 'package:jucang_app/domain/usecases/inputData.dart';
import 'package:jucang_app/pages/sales/home_page.dart';

class InputStuffPage extends StatefulWidget {
  const InputStuffPage(this.name, this.id_user, this.bearer, {Key? key}) : super(key: key);

  final String name;
  final String id_user;
  final String bearer;

  @override
  State<InputStuffPage> createState() => _InputStuffPageState();
}

class _InputStuffPageState extends State<InputStuffPage> {
  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _alamatToko = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();
  final amountController = TextEditingController();

  final input = InputDataImpl();
  late Future<List<Product>> produk;

  bool tambah = true;
  Map<String, String> amountOrder = {};
  int totalProduct = 0;

  void addAmount(String id, String amount) {
    setState(() {
      amountOrder[id] = amount;
    });
  }

  void validator(bool status) {
    if (_namaToko.text == '' || _alamatToko.text == '' || _dateInput.text == '') {
      showSnackBar(context);
    } else {
      if (status) {
        input.inputStuff(
          context,
          widget.id_user,
          _namaToko.text,
          _alamatToko.text,
          amountOrder, '1',
          _dateInput.text,
          widget.bearer,
          totalProduct,
        );
      } else {
        input.inputStuff(
          context,
          widget.id_user,
          _namaToko.text,
          _alamatToko.text,
          amountOrder, '0',
          _dateInput.text,
          widget.bearer,
          totalProduct,
        );
      }
    }
  }

  void showSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Please enter the empty field'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    _dateInput.text = "";
    produk = input.getProduct();
    super.initState();
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
              tambah = false;
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
        padding: const EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
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
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => const HomePageSales()), (route) => false);
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
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffececec),
                      // color: Colors.black54,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget> [
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Masukan nama Toko',
                          ),
                          controller: _namaToko,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Masukan Alamat Toko',
                          ),
                          controller: _alamatToko,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _dateInput,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: 'Enter Date',
                          ),
                          readOnly: true,
                          onTap: () async {

                            DateTime? pickedDate = await showDatePicker(
                                context: context, initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if (pickedDate != null ) {
                              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                _dateInput.text = formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
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
                  margin: const EdgeInsets.only(bottom: 15, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Harga: ", style: textstyle.greetings_salute),
                      Text("$totalProduct", style: textstyle.greetings_salute),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              validator(true);
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF2676DE)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          child: const Text(
                            'Lunas',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Euclid Circular B',
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              validator(false);
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFC23025)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          child: const Text(
                            'Hutang',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Euclid Circular B',
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
