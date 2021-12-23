import 'package:tourismapp/models/activity_model.dart';

class TripModel {
  final String id;
  final String guideId;
  final String guideName;
  final String guideNumber;
  final String title;
  final String location;
  final String description;
  final List<String> images;
  final int estimatedCost;
  final List<String> touristIds;
  final List<List<ActivityModel>> itinerary;

  TripModel({
    required this.id,
    required this.guideId,
    required this.guideName,
    required this.guideNumber,
    required this.title,
    required this.location,
    required this.description,
    required this.images,
    required this.estimatedCost,
    required this.itinerary,
    required this.touristIds,
  });

  static TripModel fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        guideId: json["guide_id"],
        guideName: json["guide_name"],
        guideNumber: json["guide_number"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        images: [json["images"] as List? ?? []].map((e) => e.toString()).toList(),
        estimatedCost: json["estimated_cost"],
        itinerary: ((json["itinerary"] as List?) ?? [])
            .map<List<ActivityModel>>((value) => value.map((e) => ActivityModel.fromJson(e)))
            .toList(),
        touristIds: (json["tourist_ids"] as List? ?? []).map((e) => e.toString()).toList(),
      );

  static TripModel fromJsonWithItinerary(Map<String, dynamic> json, List<List<ActivityModel>> itinerary) => TripModel(
        id: json["id"],
        guideId: json["guide_id"],
        guideName: json["guide_name"],
        guideNumber: json["guide_number"],
        title: json["title"],
        location: json["location"],
        description: json["description"],
        images: [json["images"] as List? ?? []].map((e) => e.toString()).toList(),
        estimatedCost: json["estimated_cost"],
        itinerary: itinerary,
        touristIds: (json["tourist_ids"] as List? ?? []).map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guide_id": guideId,
        "guide_name": guideName,
        "guide_number": guideNumber,
        "title": title,
        "location": location,
        "description": description,
        "images": images,
        "estimated_cost": estimatedCost,
        "itinerary": itinerary.map((e) => e.map((e) => e.toJson())).toList(),
        "tourists_ids": touristIds,
      };

  Map<String, dynamic> toJsonWithoutItinerary() => {
        "id": id,
        "guide_id": guideId,
        "guide_name": guideName,
        "guide_number": guideNumber,
        "title": title,
        "location": location,
        "description": description,
        "images": images,
        "estimated_cost": estimatedCost,
        "tourists_ids": touristIds,
      };
}
