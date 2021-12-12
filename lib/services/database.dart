import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourismapp/models/attraction_model.dart';

import '../models/user_model.dart';

abstract class Database {
  static final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference _attractionCollection = FirebaseFirestore.instance.collection('Attractions');

  static String? _getId() => FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : null;

  static Future<void> createUser(UserModel user) async {
    await _usersCollection.doc(user.id).set(user.toJson());
  }

  static Future<void> updateUser(UserModel user) async {
    await _usersCollection.doc(user.id).update(user.toJson());
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot doc = await _usersCollection.doc(id).get();
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel.fromJson(json);
  }

  static Future<void> addAttractions(List<AttractionModel> attractions) async {
    print("started adding attractions");
    for (AttractionModel attraction in attractions) {
      await _attractionCollection.doc(attraction.id).set(attraction.toJson());
    }
    print("ended adding attractions");
  }

  static Future<List<AttractionModel>> getTopAttractions() async {
    List<AttractionModel> attractions = [];
    QuerySnapshot snap = await _attractionCollection.limit(10).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    return attractions;
  }

  static Future<List<AttractionModel>> searchAttractions(String query) async {
    List<AttractionModel> attractions = [];
    QuerySnapshot snap = await _attractionCollection.limit(20).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    attractions.retainWhere((element) =>
        element.name.toLowerCase().contains(query.toLowerCase()) ||
        query.toLowerCase().contains(element.name.toLowerCase()));
    return attractions;
  }
}
