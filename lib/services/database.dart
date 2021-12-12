import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/hotel_model.dart';
import 'package:tourismapp/models/mall_model.dart';
import 'package:tourismapp/models/place_model.dart';
import 'package:tourismapp/models/restaurant_model.dart';

import '../models/guide_model.dart';
import '../models/tourist_model.dart';
import '../models/user_model.dart';

abstract class Database {
  static final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference _attractionCollection = FirebaseFirestore.instance.collection('Attractions');

  static String? _getId() => FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.uid : null;

  static Future<void> createTourist(TouristModel tourist) async {
    await _usersCollection.doc(tourist.id).set(tourist.toJson());
  }

  static Future<void> updateTourist(TouristModel tourist) async {
    await _usersCollection.doc(tourist.id).update(tourist.toJson());
  }

  static Future<UserModel> getUser(String id) async {
    DocumentSnapshot doc = await _usersCollection.doc(id).get();
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel.isTourist(json) ? TouristModel.fromJson(json) : GuideModel.fromJson(json);
  }

  static Future<void> addAttractions(List<AttractionModel> attractions) async {
    print("started adding attractions");
    for (AttractionModel attraction in attractions) {
      if (attraction.type == AttractionType.mall) {
        await _attractionCollection.doc(attraction.id).set((attraction as MallModel).toJson());
      } else if (attraction.type == AttractionType.place) {
        await _attractionCollection.doc(attraction.id).set((attraction as PlaceModel).toJson());
      } else if (attraction.type == AttractionType.restaurant) {
        await _attractionCollection.doc(attraction.id).set((attraction as RestaurantModel).toJson());
      } else if (attraction.type == AttractionType.hotel) {
        await _attractionCollection.doc(attraction.id).set((attraction as HotelModel).toJson());
      }
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
