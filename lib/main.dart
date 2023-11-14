import 'package:flutter/material.dart';
import 'package:support_ticket_app/splash/splash.dart';
import 'services/auth.dart';
import 'login/login.dart';
import 'tickets/tickets.dart';
import 'package:google_fonts/google_fonts.dart';

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
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color(0xAA01579b))),
      home: FutureBuilder<bool>(
          future: authManager.checkAuth(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return Tickets(); // If authenticated, show tickets page
              } else {
                return LoginScreen(); // If not authenticated, show login page
              }
            } else {
              return const SplashScreen();
            }
          }),
      // home: StreamBuilder<bool>(
      //     stream: authManager.authState,
      //     initialData: true, // Initial authentication state
      //     builder: (context, snapshot) {
      //       if (snapshot.data == true) {
      //         return Tickets(); // If authenticated, show tickets page
      //       } else {
      //         return LoginScreen(
      //             authManager:
      //                 authManager); // If not authenticated, show login page
      //       }
      //     }),
      routes: {
        '/login': (context) => LoginScreen(),
        '/tickets': (context) => Tickets(),
      },
    );
  }
}
