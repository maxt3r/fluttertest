import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../services/ticket.dart';

class TicketItem extends StatelessWidget {
  const TicketItem({super.key, required this.tickets, required this.index});

  final List<SupportTicket> tickets;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ticket = tickets[index];
    final relativeTime = timeago.format(DateTime.parse(ticket.issueDate));
    return Container(
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          color: getBadgeColor(ticket),
          width: 5.0,
        ),
      )),
      child: ListTile(
        title: Text(ticket.subject),
        subtitle: Text('${ticket.category} - ${ticket.userName}'),
        trailing: Text(relativeTime),
      ),
    );
  }

  Color getBadgeColor(SupportTicket ticket) {
    if (ticket.statusID == 3) {
      // closed
      return const Color(0xAA6b7280); // Replace with the actual color you want
    } else if (ticket.updatedByUser == true) {
      // updByCust
      return const Color(0xAAd97706); // Replace with the actual color
    } else if (ticket.updatedByPerformer == true) {
      // updByTech
      return const Color(0xAA22c55e); // Replace with the actual color
    } else if (ticket.updatedForTechView == true) {
      // updForTech
      return const Color(0xAA0891b2); // Replace with the actual color
    } else if (ticket.statusID == 1) {
      // new
      return const Color(0xAAdc2626); // Replace with the actual color
    } else {
      return const Color(
          0xAA6b7280); // A default color if none of the conditions are met
    }
  }
}
