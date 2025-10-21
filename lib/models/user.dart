import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String username;
  final String profilePictureUrl;

  User({
    required this.uid,
    required this.email,
    required this.username,
    required this.profilePictureUrl,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      email: data['email'] ?? '',
      username: data['username'] ?? '',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
