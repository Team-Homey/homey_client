import 'package:flutter/material.dart';

class JoinFamily extends StatefulWidget {
  const JoinFamily({Key? key}) : super(key: key);

  @override
  JoinFamilyState createState() => JoinFamilyState();
}

class JoinFamilyState extends State<JoinFamily> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Join Family',
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
            title: const Text('Join Family',
                style: TextStyle(color: Colors.white)),
          ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Join Family',
                ),
              ],
            ),
          ),
        ));
  }
}
