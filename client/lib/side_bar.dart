import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'google_login.dart';

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
              width: 160,
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
    contact,
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
  static const contact = MenuItem(text: 'Contact', icon: Icons.contact_page);
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.gallery:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.recommendation:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.records:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.level:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.video:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.todo:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.contact:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.settings:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
      case MenuItems.logout:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GoogleLogin()),
        );
        break;
    }
  }
}
