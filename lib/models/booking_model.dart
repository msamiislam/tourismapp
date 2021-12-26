import 'package:tourismapp/models/tourist_model.dart';
import 'package:tourismapp/models/trip_model.dart';

class BookingModel {
  final TripModel trip;
  final TouristModel tourist;

  BookingModel({required this.trip, required this.tourist});
}
