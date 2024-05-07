import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String heading;
  final String link;
  final String type;
  final String description;
  final Timestamp timestamp;
  final String coverLogo;

  ProjectModel({
    required this.id,
    required this.heading,
    required this.link,
    required this.type,
    required this.description,
    required this.timestamp,
    required this.coverLogo,
  });

  factory ProjectModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ProjectModel(
      id: doc.id,
      heading: data['heading'] ?? '',
      link: data['link'] ?? '',
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      coverLogo: data['cover_logo'] ?? '',
    );
  }
}
