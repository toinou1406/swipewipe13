import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String userId;
  final DateTime createdAt;

  Photo({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.userId,
    required this.createdAt,
  });

  factory Photo.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Photo(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': createdAt,
    };
  }
}
