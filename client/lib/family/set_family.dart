import 'package:flutter/material.dart';

import 'build_new_family.dart';
import 'join_family.dart';

class SetFamily extends StatefulWidget {
  const SetFamily({Key? key}) : super(key: key);

  @override
  SetFamilyState createState() => SetFamilyState();
}

class SetFamilyState extends State<SetFamily> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Family',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Family Invite / Join',
                style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Image(
                  image: const AssetImage('assets/images/Logo_White.png'),
                  width: MediaQuery.of(context).size.width * 0.6,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BuildNewFamily()));
                      },
                      child: Container(
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Build New Family',
                              style: TextStyle(color: Colors.white))),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JoinFamily()));
                      },
                      child: Container(
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text('Join Family',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
