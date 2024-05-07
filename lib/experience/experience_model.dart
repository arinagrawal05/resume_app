import 'package:cloud_firestore/cloud_firestore.dart';

class ExperienceModel {
  final String id;
  final String title;
  final String role;
  final String type;
  final Timestamp timestamp;
  final Timestamp startDate;
  final Timestamp endDate;
  final String location;
  final String coverLogo;
  final bool isPresent;
  final String link;
  final String companyName;

  ExperienceModel({
    required this.id,
    required this.title,
    required this.role,
    required this.type,
    required this.timestamp,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.coverLogo,
    required this.isPresent,
    required this.link,
    required this.companyName,
  });

  factory ExperienceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ExperienceModel(
      id: doc.id,
      title: data['title'] ?? '',
      role: data['role'] ?? '',
      type: data['type'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      startDate: data['start_date'] ?? Timestamp.now(),
      endDate: data['end_date'] ?? Timestamp.now(),
      location: data['location'] ?? '',
      coverLogo: data['cover_logo'] ?? '',
      isPresent: data['isPresent'] ?? false,
      link: data['link'] ?? '',
      companyName: data['company_name'] ?? 'Amazon',
    );
  }
}
