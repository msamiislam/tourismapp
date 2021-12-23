import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourismapp/models/attraction_model.dart';
import 'package:tourismapp/models/booking_model.dart';
import 'package:tourismapp/models/tourist_model.dart';
import 'package:tourismapp/models/trip_model.dart';

import '../models/user_model.dart';

abstract class Database {
  static final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('Users');
  static final CollectionReference _attractionCollection = FirebaseFirestore.instance.collection('Attractions');
  static final CollectionReference _tripsCollection = FirebaseFirestore.instance.collection('Trips');

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

  static Future<void> addTrips(TripModel model) async {
    log("started adding trip");
    log(model.id.toString());
    await _tripsCollection.doc(model.id).set(model.toJson());
    log("ended adding trip");
  }

  static Future<List<AttractionModel>> getTopAttractions() async {
    List<AttractionModel> attractions = [];
    QuerySnapshot snap = await _attractionCollection.limit(10).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    return attractions;
  }

  static Future<List<AttractionModel>> getAttractions(List<String> attractionsIds) async {
    List<AttractionModel> attractions = [];
    if (attractionsIds.isEmpty) return attractions;
    QuerySnapshot snap = await _tripsCollection.where("id", arrayContainsAny: attractionsIds).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    return attractions;
  }

  static Future<List<TripModel>> getTrips(List<String> tripsIds) async {
    List<TripModel> trips = [];
    if (tripsIds.isEmpty) return trips;
    QuerySnapshot snap = await _tripsCollection.where("id", arrayContainsAny: tripsIds).get();
    trips.addAll(snap.docs.map((e) => TripModel.fromJson((e.data() as Map<String, dynamic>))));
    return trips;
  }

  static Future<List<AttractionModel>> searchAttractions(String query) async {
    List<AttractionModel> attractions = [];
    QuerySnapshot snap = await _attractionCollection.limit(20).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    attractions.retainWhere((element) =>
        element.name.toLowerCase().contains(query.toLowerCase()) || query.toLowerCase().contains(element.name.toLowerCase()));
    return attractions;
  }

  static Future<List<BookingModel>> getBookings(List<String> tripsIds) async {
    List<BookingModel> bookings = [];
    if (tripsIds.isEmpty) return bookings;
    List<TripModel> trips = [];
    QuerySnapshot snap = await _tripsCollection.where("id", arrayContainsAny: tripsIds).get();
    if (snap.docs.isEmpty) return bookings;
    trips.addAll(snap.docs.map((e) => TripModel.fromJson((e.data() as Map<String, dynamic>))));
    for (TripModel trip in trips) {
      QuerySnapshot snap = await _usersCollection.where("id", arrayContainsAny: trip.touristIds).get();
      if (snap.docs.isEmpty) continue;
      snap.docs.map((e) {
        TouristModel tourist = TouristModel.fromJson((e.data() as Map<String, dynamic>));
        bookings.add(BookingModel(trip: trip, tourist: tourist));
      });
    }
    return bookings;
  }
}
