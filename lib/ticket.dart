class SupportTicket {
  final int issueID;
  final int priority;
  final int statusID;
  final String issueDate;
  final String subject;
  final String status;
  final String userName;
  final String category;

  SupportTicket({
    required this.issueID,
    required this.priority,
    required this.statusID,
    required this.issueDate,
    required this.subject,
    required this.status,
    required this.userName,
    required this.category,
  });

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
      issueID: json['IssueID'],
      priority: json['Priority'],
      statusID: json['StatusID'],
      issueDate: json['IssueDate'],
      subject: json['Subject'],
      status: json['Status'],
      userName: json['UserName'],
      category: json['Category'],
    );
  }
}
