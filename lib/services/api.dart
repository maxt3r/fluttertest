import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:support_ticket_app/services/ticket.dart';

class API {
  final String baseUri;
  final String token;

  static API? _instance;

  // Private constructor
  API._internal({required this.baseUri, required this.token});

  // Public static method to initialize the API
  static void initialize(String baseUri, String token) {
    _instance ??= API._internal(baseUri: baseUri, token: token);
  }

  // Getter to access the instance
  static API get instance {
    if (_instance == null) {
      throw Exception('API not initialized');
    }
    return _instance!;
  }

  // Method to get headers
  Map<String, String> _getHeaders() {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept-Encoding': 'gzip',
    };
  }

  // Authorization Test
  Future<bool> testAuthorization() async {
    final uri = Uri.parse('$baseUri/api/Authorization');
    final response = await http.post(uri, headers: _getHeaders());

    return response.statusCode == 200;
  }

  // Get Tickets
  Future<List<SupportTicket>> getTickets(
      {Map<String, dynamic>? parameters}) async {
    var tickets = <SupportTicket>[];
    var queryParameters = parameters ?? {};
    queryParameters.addAll({"count": "50"});
    final uri = Uri.parse('$baseUri/api/Tickets')
        .replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> ticketData = json.decode(response.body);
      return ticketData.map((json) => SupportTicket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  // Get Ticket Details
  Future<Map<String, dynamic>> getTicketDetails(int ticketId) async {
    final uri = Uri.parse('$baseUri/api/ticket?id=$ticketId');
    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get ticket details');
    }
  }

  // Create a Ticket
  Future<int> createTicket(Map<String, dynamic> ticketData) async {
    final uri = Uri.parse('$baseUri/api/ticket');
    final response = await http.post(uri,
        headers: _getHeaders(), body: json.encode(ticketData));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create ticket');
    }
  }

  // Update a Ticket
  Future<void> updateTicket(
      int ticketId, Map<String, dynamic> updateData) async {
    final uri = Uri.parse('$baseUri/api/UpdateTicket?id=$ticketId');
    final response = await http.post(uri,
        headers: _getHeaders(), body: json.encode(updateData));

    if (response.statusCode == 200) {
      print('Ticket updated successfully');
    } else {
      throw Exception('Failed to update ticket');
    }
  }

  // Get Statistics
  Future<Map<String, dynamic>> getStats() async {
    final uri = Uri.parse('$baseUri/api/Stats');
    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get stats');
    }
  }

  // Additional methods can be added here following the same pattern
}
