import 'package:flutter/material.dart';
import 'package:support_ticket_app/services/api.dart';

class SideMenu extends StatelessWidget {
  SideMenu({super.key});
  ViewMode _viewMode = ViewMode.unanswered;

  void changeViewMode(ViewMode? value) {
    _viewMode = value!;
    print('mode $_viewMode');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Jitbit Helpdesk'),
          ),
          ListTile(
            title: Text('Unanswered'),
            leading: Radio<ViewMode>(
              value: ViewMode.unanswered,
              groupValue: _viewMode,
              onChanged: (value) => changeViewMode(value),
            ),
          ),
          ListTile(
            title: Text('Unclosed'),
            leading: Radio<ViewMode>(
              value: ViewMode.unclosed,
              groupValue: _viewMode,
              onChanged: (value) => changeViewMode(value),
            ),
          ),
          ListTile(
            title: Text('Handled by me'),
            leading: Radio<ViewMode>(
              value: ViewMode.handledbyme,
              groupValue: _viewMode,
              onChanged: (value) => changeViewMode(value),
            ),
          ),
          ListTile(
            title: Text('All'),
            leading: Radio<ViewMode>(
              value: ViewMode.all,
              groupValue: _viewMode,
              onChanged: (value) => changeViewMode(value),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () async {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
