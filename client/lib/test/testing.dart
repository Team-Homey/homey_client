import 'package:flutter/material.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

  @override
  TestingState createState() => TestingState();
}

class TestingState extends State<Testing> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Test', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
                margin: const EdgeInsets.only(left: 30.0, top: 40),
                child: Image.asset('assets/images/testlist1.png')),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: 350,
                margin: const EdgeInsets.only(left: 20.0),
                child: Image.asset('assets/images/testlist2.png')),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: 200,
                //margin: const EdgeInsets.only(left: 20.0),
                child: Image.asset('assets/images/testlist3.png'))
          ])),
    );
  }
}
