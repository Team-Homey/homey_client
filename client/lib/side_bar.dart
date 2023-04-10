import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'google_login.dart';
import 'test/test.dart';

class CustomButtonTest extends StatefulWidget {
  const CustomButtonTest({Key? key}) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            customButton: Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value as MenuItem);
            },
            dropdownStyleData: DropdownStyleData(
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              elevation: 8,
              offset: const Offset(0, 8),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    profile,
    gallery,
    recommendation,
    records,
    level,
    video,
    todo,
    test,
    settings
  ];
  static const List<MenuItem> secondItems = [logout];

  static const profile = MenuItem(text: 'My Profile', icon: Icons.person);
  static const gallery = MenuItem(text: 'Gallery', icon: Icons.photo);
  static const recommendation = MenuItem(text: 'Recommend', icon: Icons.star);
  static const records = MenuItem(text: 'Records', icon: Icons.edit_note);
  static const level = MenuItem(text: 'Level', icon: Icons.trending_up);
  static const video = MenuItem(text: 'Video', icon: Icons.video_collection);
  static const todo = MenuItem(text: 'To Do', icon: Icons.checklist);
  static const test = MenuItem(text: 'Test', icon: Icons.quiz);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.profile:
        break;
      case MenuItems.gallery:
        break;
      case MenuItems.recommendation:
        break;
      case MenuItems.records:
        break;
      case MenuItems.level:
        break;
      case MenuItems.video:
        break;
      case MenuItems.todo:
        break;
      case MenuItems.test:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TestShow()),
        );
        break;
      case MenuItems.settings:
        break;
      case MenuItems.logout:
        () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        };
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
    }
  }
}
