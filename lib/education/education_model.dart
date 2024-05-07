import 'package:cloud_firestore/cloud_firestore.dart';

class EducationModel {
  final String id;
  final String institute;
  final String degree;
  final String location;
  final Timestamp timestamp;
  final Timestamp startDate;
  final Timestamp endDate;
  final bool isPresent;
  final String coverLogo;

  EducationModel({
    required this.id,
    required this.institute,
    required this.degree,
    required this.location,
    required this.timestamp,
    required this.startDate,
    required this.endDate,
    required this.isPresent,
    required this.coverLogo,
  });

  factory EducationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return EducationModel(
      id: doc.id,
      institute: data['institute'] ?? '',
      degree: data['degree'] ?? '',
      location: data['location'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      startDate: data['start_date'] ?? Timestamp.now(),
      endDate: data['end_date'] ?? Timestamp.now(),
      isPresent: data['isPresent'] ?? false,
      coverLogo: data['cover_logo'] ?? '',
    );
  }
}
