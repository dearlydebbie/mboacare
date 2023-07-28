// TODO Implement this library.
import 'package:flutter/material.dart';

class MboacareNavigationDrawer extends StatelessWidget {
  final String? userName;

  MboacareNavigationDrawer({this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Welcome, ${userName ?? 'Guest'}!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Handle the home navigation here
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Handle the settings navigation here
              Navigator.pop(context);
            },
          ),
          // Add more list items for other navigation options as needed
        ],
      ),
    );
  }
}
