import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Jitbit Helpdesk'),
          ),
          ListTile(
            title: Text('Tickets'),
            onTap: () {
              Navigator.pushNamed(context, '/tickets');
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () async {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
