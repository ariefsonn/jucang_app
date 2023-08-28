import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';
import 'package:intl/intl.dart';

class InputStuffPage extends StatefulWidget {
  const InputStuffPage({Key? key}) : super(key: key);

  @override
  State<InputStuffPage> createState() => _InputStuffPageState();
}

class _InputStuffPageState extends State<InputStuffPage> {
  final TextEditingController _namaToko = TextEditingController();
  final TextEditingController _dateInput = TextEditingController();

  int produk_a = 0;
  int produk_b = 0;
  int produk_c = 0;

  void incrementA() {
    setState(() {
      produk_a++;
    });
  }
  void incrementB() {
    setState(() {
      produk_b++;
    });
  }
  void incrementC() {
    setState(() {
      produk_c++;
    });
  }
  void decrementA() {
    setState(() {
      if (produk_a > 0) {
        produk_a--;
      }
    });
  }
  void decrementB() {
    setState(() {
      if (produk_b > 0) {
        produk_b--;
      }
    });
  }
  void decrementC() {
    setState(() {
      if (produk_c > 0) {
        produk_c--;
      }
    });
  }

  @override
  void initState() {
    _dateInput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 45, bottom: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
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
                    children: const [
                      Icon(Icons.keyboard_arrow_left_rounded),
                      Center(child: Text('Ludwig Göransson', style: textstyle.greetings_salute)),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 170,
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
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
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
                Container(
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
                      const Text('Produk A', style: textstyle.style_namaToko),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: decrementA,
                            child: const Icon(Icons.remove, size: 21),
                          ),
                          const SizedBox(width: 15),
                          Text('$produk_a'),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: incrementA,
                            child: const Icon(Icons.add, size: 21),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
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
                      const Text('Produk B', style: textstyle.style_namaToko),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: decrementB,
                            child: const Icon(Icons.remove, size: 21),
                          ),
                          const SizedBox(width: 15),
                          Text('$produk_b'),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: incrementB,
                            child: const Icon(Icons.add, size: 21),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
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
                      const Text('Produk C', style: textstyle.style_namaToko),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: decrementC,
                            child: const Icon(Icons.remove, size: 21),
                          ),
                          const SizedBox(width: 15),
                          Text('$produk_c'),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: incrementC,
                            child: const Icon(Icons.add, size: 21),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
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
                SizedBox(
                  width: 180,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {},
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
