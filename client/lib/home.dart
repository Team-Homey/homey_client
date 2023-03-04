import 'package:flutter/material.dart';

import 'side_bar.dart';

class Homey extends StatelessWidget {
  const Homey({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homey',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Homey',
              style: TextStyle(color: Colors.white, fontFamily: "roboto"),
              textAlign: TextAlign.center),
          centerTitle: true,
          leading: const CustomButtonTest(),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
