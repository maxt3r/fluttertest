import 'package:flutter/material.dart';
import 'package:support_ticket_app/services/api.dart';
import 'services/auth.dart';
import 'login/login.dart';
import 'tickets/tickets.dart';

void main() {
  runApp(SupportTicketApp());
}

class SupportTicketApp extends StatelessWidget {
  final AuthManager authManager = AuthManager();
  SupportTicketApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jitbit Helpdesk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<bool>(
          stream: authManager.authState,
          initialData: true, // Initial authentication state
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return Tickets(); // If authenticated, show tickets page
            } else {
              return LoginScreen(
                  authManager:
                      authManager); // If not authenticated, show login page
            }
          }),
      routes: {
        //'/login': (context) => LoginScreen(authManager),
        '/tickets': (context) => Tickets(),
      },
    );
  }
}
