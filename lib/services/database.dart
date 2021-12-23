import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourismapp/models/activity_model.dart';
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

  static Future<List<UserModel>> getUsers(String userType, {int? limit}) async {
    List<UserModel> users = [];
    Query query = _usersCollection.where('user_type', isEqualTo: userType);
    if (limit != null) {
      query = query.limit(limit);
    }
    QuerySnapshot snap = await query.get();
    for (QueryDocumentSnapshot doc in snap.docs) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      users.add(UserModel.fromJson(json));
    }
    return users;
  }

  static Future<void> addAttractions(List<AttractionModel> attractions) async {
    print("started adding attractions");
    for (AttractionModel attraction in attractions) {
      await _attractionCollection.doc(attraction.id).set(attraction.toJson());
    }
    print("ended adding attractions");
  }

  static Future<void> addTrip(TripModel model) async {
    log("started adding trip");
    log(model.id.toString());
    await _tripsCollection.doc(model.id).set(model.toJsonWithoutItinerary());
    for (int i = 0; i < model.itinerary.length; i++) {
      await _tripsCollection
          .doc(model.id)
          .collection('itinerary')
          .doc("$i")
          .set({"$i": model.itinerary[i].map((e) => e.toJson()).toList()});
    }
    log("ended adding trip");
  }

  static Future<List<AttractionModel>> getTopAttractions() async {
    List<AttractionModel> attractions = [];
    QuerySnapshot snap = await _attractionCollection.limit(10).get();
    attractions.addAll(snap.docs.map((e) => AttractionModel.fromJson((e.data() as Map<String, dynamic>))));
    return attractions;
  }

  static Future<List<AttractionModel>> getAttractions(List<String> attractionsIds) async {
    log(attractionsIds.length.toString());
    List<AttractionModel> attractions = [];
    if (attractionsIds.isEmpty) return attractions;
    for (String id in attractionsIds) {
      DocumentSnapshot doc = await _attractionCollection.doc(id).get();
      attractions.add(AttractionModel.fromJson(doc.data() as Map<String, dynamic>));
    }
    log(attractions.length.toString());
    return attractions;
  }

  static Future<List<TripModel>> getTrips(List<String> tripsIds) async {
    List<TripModel> trips = [];
    for (String id in tripsIds) {
      List<List<ActivityModel>> daysActivities = [];
      DocumentSnapshot doc = await _tripsCollection.doc(id).get();
      QuerySnapshot itinerarySnap = await _tripsCollection.doc(id).collection('itinerary').get();
      for (QueryDocumentSnapshot doc in itinerarySnap.docs) {
        List<ActivityModel> activities = [];
        (doc.data() as Map<String, dynamic>).forEach((key, value) {
          activities.addAll((value as List).map((e) => ActivityModel.fromJson(e)));
        });
        daysActivities.add(activities);
      }
      print(daysActivities);

      trips.add(TripModel.fromJsonWithItinerary((doc.data() as Map<String, dynamic>), daysActivities));
    }
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
    List<TripModel> trips = await getTrips(tripsIds);
    List<BookingModel> bookings = [];
    for (TripModel trip in trips) {
      for (String id in trip.touristIds) {
        DocumentSnapshot doc = await _usersCollection.doc(id).get();
        bookings.add(BookingModel(
          trip: trip,
          tourist: TouristModel.fromJson((doc.data() as Map<String, dynamic>)),
        ));
      }
    }
    return bookings;
  }

  static Future<void> updateFavAttraction(TouristModel tourist) async {
    await _usersCollection.doc(tourist.id).update(tourist.toJson());
  }

  static bookTrip(String tripId, List<String> userIds) async {
    await _tripsCollection.doc(tripId).update({"tourist_ids": userIds});
  }
}
