import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ticket.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  runApp(SupportTicketApp());
}

class SupportTicketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Support Ticket App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SupportTicket> tickets = [];

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    var url = Uri.parse('https://support.jitbit.com/helpdesk/api/tickets');
    // Your username and password for basic auth
    String username = 'max';
    String password = '...';

    // Encoding username and password in base64
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    http.Response response;
    try {
      response = await http.get(url, headers: <String, String>{
        'authorization': basicAuth,
      });

      if (response.statusCode == 200) {
        List<dynamic> ticketData = json.decode(response.body);
        setState(() {
          tickets =
              ticketData.map((data) => SupportTicket.fromJson(data)).toList();
        });
      } else {
        // Handle error
        print('Failed to load tickets');
      }
    } catch (e) {
      print('Caught error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Tickets'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Handle menu button action
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchTickets,
          ),
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
            final ticket = tickets[index];
            final relativeTime =
                timeago.format(DateTime.parse(ticket.issueDate));
            return ListTile(
              title: Text(ticket.subject),
              subtitle: Text('${ticket.category} - ${ticket.userName}'),
              trailing: Text(relativeTime),
            );
          },
        ),
      ),
    );
  }
}
