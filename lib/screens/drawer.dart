// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, unused_local_variable, constant_identifier_names, prefer_const_declarations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/addprop_screen.dart';
import 'package:flutter_application_1/screens/contact_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/myprop_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
//import 'package:flutter/widgets.dart';
//import 'package:flutter_application_1/screens/registration_screen.dart';
import 'package:flutter_application_1/search_screen/search_screen.dart';
import 'package:flutter_application_1/screens/test.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final String name;
  final String email;
  final Padding = EdgeInsets.symmetric(horizontal: 20);

  NavigationDrawerWidget({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        "https://i.pinimg.com/originals/06/81/39/068139bff0b22024e775bfcbb42ed3b4.jpg";
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: Scrollbar(
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
              BuildMenuItem(
                text: 'Home',
                icon: CupertinoIcons.home,
                onClicked: () => selectedItem(context, 0),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'Add Property',
                icon: CupertinoIcons.plus,
                onClicked: () => selectedItem(context, 1),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'Search Properties',
                icon: CupertinoIcons.search,
                onClicked: () => selectedItem(context, 2),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'My Properties',
                icon: CupertinoIcons.house,
                onClicked: () => selectedItem(context, 3),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'Contact Us',
                icon: CupertinoIcons.phone,
                onClicked: () => selectedItem(context, 4),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'Profile Setting',
                icon: CupertinoIcons.settings,
                onClicked: () => selectedItem(context, 5),
              ),
              const SizedBox(height: 16),
              BuildMenuItem(
                text: 'Logout',
                icon: CupertinoIcons.backward,
                onClicked: () => selectedItem(context, 6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildMenuItem({
    required String text,
    required icon,
    VoidCallback? onClicked,
  }) {
    final Color = Colors.white;

    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(icon, color: Color),
      title: Text(text, style: TextStyle(color: Color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => homescreen()));
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => addProperty()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SearchProperty()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => myproperty()));
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ContactUs()));
        break;
      case 5:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => profilesetting()));
        break;
      case 6:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => test()));
        break;
    }
  }
}
