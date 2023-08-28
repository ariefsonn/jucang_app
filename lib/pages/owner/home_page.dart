import 'package:flutter/material.dart';
import 'package:jucang_app/base/constant.dart';

class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  State<OwnerHomePage> createState() => _OwnerHomePageState();
}

class _OwnerHomePageState extends State<OwnerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 45),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
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
              child: const Text('Ludwig Göransson', style: textstyle.greetings_salute),
            ),
            const SizedBox(height: 30),
            const Text('Sales: ', style: textstyle.style_titleinput),
            const SizedBox(height: 15),
            SizedBox(
              height: 610,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 30,
                itemBuilder: (BuildContext context, int i) {
                  return GestureDetector(
                    child: Container(
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
                        children: const <Widget> [
                          Text('Harya Suryatama', style: textstyle.style_namaToko),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
