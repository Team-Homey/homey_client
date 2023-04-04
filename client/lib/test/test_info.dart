import 'package:flutter/material.dart';

import 'testing.dart';

class TestInfo extends StatefulWidget {
  const TestInfo({Key? key}) : super(key: key);

  @override
  TestInfoState createState() => TestInfoState();
}

class TestInfoState extends State<TestInfo> {
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
          title: const Text('Test information',
              style: TextStyle(color: Colors.white)),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Is our family Homey?",
              style: TextStyle(fontSize: 30, color: Colors.amber),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Check your stress and make your family Homey!",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Text(
                "The Family Relations Crisis Diagnosis Scale developed by the Korea Healthy Family Support Center in 2013 was developed to more easily and quickly survey the family relationships of users of Healthy Family Support Centers across the country, and to provide appropriate services of Healthy Family Support Centers to users. This application guide is designed to provide convenience for practitioners of local healthy family support centers to use the Family Relations Crisis Diagnosis Scale and result analysis.",
                style: TextStyle(
                    fontSize: 18, fontFamily: "roboto", color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Information'),
                        content: const SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'Has your family experienced any of the following in the past 12 months? If you have no experience, please indicate the level of stress you felt from the experience on a scale of 1 to 5. '),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Confirm'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Testing()),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Start Test',
                    style: TextStyle(fontSize: 15, color: Colors.white)))
          ],
        )));
  }
}
