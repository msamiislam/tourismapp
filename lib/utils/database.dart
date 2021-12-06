import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourismapp/model/guide_model.dart';
import 'package:tourismapp/model/tourist_model.dart';
import 'package:tourismapp/model/user_model.dart';

abstract class Database {
  static final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('Users');

  static String? _getId() => FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : null;

  static Future<void> createTourist(TouristModel tourist) async {
    await _usersCollection.doc(tourist.id).set(tourist.toJson());
  }

  static Future<UserModel> getTourist(String id) async {
    DocumentSnapshot doc = await _usersCollection.doc(id).get();
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel.isTourist(json) ? TouristModel.fromJson(json) : GuideModel.fromJson(json);
  }
}
