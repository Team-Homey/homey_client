import 'package:flutter/material.dart';

import 'side_bar.dart';
import 'pages/gallery.dart';
import 'pages/home.dart';
import 'pages/record.dart';
import 'pages/recommend.dart';
import 'pages/today.dart';

class Homey extends StatefulWidget {
  const Homey({super.key});

  @override
  State<Homey> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Homey> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    recommendShow(),
    galleryShow(),
    homeScreenShow(),
    recordShow(),
    todayShow(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Homey',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Homey',
                style: TextStyle(
                    color: Colors.white, fontFamily: "roboto", fontSize: 22),
                textAlign: TextAlign.center),
            centerTitle: true,
            leading: const CustomButtonTest(),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications_none),
                color: Colors.white,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                color: Colors.white,
                onPressed: () {},
              ),
            ],
          ),
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
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
                icon: Icon(Icons.edit_note),
                label: 'My Record',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Today",
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            unselectedItemColor: Colors.grey[600],
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        ));
  }
}
