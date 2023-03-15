import 'package:flutter/material.dart';

class BuildNewFamily extends StatefulWidget {
  const BuildNewFamily({Key? key}) : super(key: key);

  @override
  BuildNewFamilyState createState() => BuildNewFamilyState();
}

class BuildNewFamilyState extends State<BuildNewFamily> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Build New Family',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Build New Family',
                style: TextStyle(color: Colors.white)),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Build New Family',
                ),
              ],
            ),
          ),
        ));
  }
}
