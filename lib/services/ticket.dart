class SupportTicket {
  final int issueID;
  final int priority;
  final int statusID;
  final String issueDate;
  final String subject;
  final String status;
  final bool? updatedByUser;
  final bool? updatedByPerformer;
  final int? categoryID;
  final String userName;
  final String? technician;
  final String? firstName;
  final String? lastName;
  final String? dueDate;
  final String? techFirstName;
  final String? techLastName;
  final String lastUpdated;
  final int? userID;
  final int? companyID;
  final String? companyName;
  final int? sectionID;
  final int? assignedToUserID;
  final String category;
  final bool? updatedForTechView;

  SupportTicket(
      {required this.issueID,
      required this.priority,
      required this.statusID,
      required this.issueDate,
      required this.subject,
      required this.status,
      required this.updatedByUser,
      required this.updatedByPerformer,
      this.categoryID,
      required this.userName,
      this.technician,
      this.firstName,
      this.lastName,
      this.dueDate,
      this.techFirstName,
      this.techLastName,
      required this.lastUpdated,
      this.userID,
      this.companyID,
      this.companyName,
      this.sectionID,
      this.assignedToUserID,
      required this.category,
      required this.updatedForTechView});

  factory SupportTicket.fromJson(Map<String, dynamic> json) {
    return SupportTicket(
        issueID: json['IssueID'],
        priority: json['Priority'],
        statusID: json['StatusID'],
        issueDate: json['IssueDate'],
        subject: json['Subject'],
        status: json['Status'],
        updatedByUser: json['UpdatedByUser'],
        updatedByPerformer: json['UpdatedByPerformer'],
        categoryID: json['CategoryID'],
        userName: json['UserName'],
        technician: json['Technician'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        dueDate: json['DueDate'],
        techFirstName: json['TechFirstName'],
        techLastName: json['TechLastName'],
        lastUpdated: json['LastUpdated'],
        userID: json['UserID'],
        companyID: json['CompanyID'],
        companyName: json['CompanyName'],
        sectionID: json['SectionID'],
        assignedToUserID: json['AssignedToUserID'],
        category: json['Category'],
        updatedForTechView: json['UpdatedForTechView']);
  }
}
