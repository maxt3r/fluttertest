import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:support_ticket_app/tickets/drawer.dart';
import 'dart:convert';
import '../services/auth.dart';
import '../services/ticket.dart';
import '../services/api.dart';
import 'ticket-item.dart';

class Tickets extends StatefulWidget {
  const Tickets({super.key});

  @override
  _TicketsState createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  List<SupportTicket> tickets = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      tickets = [];
    });

    () async {
      AuthManager authManager = AuthManager();
      if (await authManager.checkAuth() == true) {
        var tickets = await fetchTickets();
        setState(() {
          this.tickets = tickets;
        });
      }
    }();
  }

  Future<List<SupportTicket>> fetchTickets() async {
    return await API.instance!.getTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Builder(builder: (context) {
          return InkWell(
              child: Center(child: Text('Support Tickets')),
              onTap: () => Scaffold.of(context).openDrawer());
        }),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.refresh),
          //   onPressed: fetchTickets,
          // ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle add new ticket action
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchTickets,
        child: ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            return TicketItem(tickets: tickets, index: index);
          },
        ),
      ),
    );
  }
}
