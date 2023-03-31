import 'package:flutter/material.dart';

import 'test_result.dart';
import 'testing.dart';

class TestShow extends StatefulWidget {
  const TestShow({Key? key}) : super(key: key);

  @override
  TestState createState() => TestState();
}

class TestState extends State<TestShow> {
  int _selectedIndex = 1;
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget showTest(String testdate) {
    bool _isPressed = false;
    return GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            _isPressed = false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TestResult()));
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: // show tags with horizontal scroll
                Container(
              margin: const EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: _isPressed ? Colors.grey[300] : Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(testdate,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          child: Stack(children: [
            Center(
                child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: const Text(' Check out your test results ',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                        fontFamily: "roboto",
                      ))),
              const SizedBox(height: 10),
              Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              showTest("2022.11.13"),
                              showTest("2022.12.07"),
                              showTest("2023.01.04"),
                              showTest("2023.01.16"),
                              showTest("2023.03.24"),
                            ],
                          ))))
            ])),
            Positioned(
              bottom: 60,
              right: 30,
              child: FloatingActionButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Testing()));
                },
                child: const Icon(Icons.add,
                    color: Color.fromARGB(255, 255, 255, 255), size: 40),
              ),
            ),
          ])),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Recommend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
          ),
        ],
        selectedItemColor: Colors.grey[600],
        unselectedItemColor: Colors.grey[600],
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
