import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as app_user;
import '../models/photo.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User methods
  Future<void> addUser(app_user.User user) {
    return _db.collection('users').doc(user.uid).set(user.toFirestore());
  }

  Stream<app_user.User> streamUser(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snap) => app_user.User.fromFirestore(snap));
  }

  // Photo methods
  Future<void> addPhoto(Photo photo) {
    return _db.collection('photos').add(photo.toFirestore());
  }

  Stream<List<Photo>> streamPhotos() {
    return _db.collection('photos').snapshots().map((snap) {
      return snap.docs.map((doc) => Photo.fromFirestore(doc)).toList();
    });
  }

  Future<void> deletePhoto(String photoId) {
    return _db.collection('photos').doc(photoId).delete();
  }
}
