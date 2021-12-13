import 'package:tourismapp/models/activity_model.dart';

class DayModel {
  int activitiesCount;
  List<ActivityModel> activities;

  DayModel({this.activitiesCount = 1}): activities = List.generate(activitiesCount, (index) => ActivityModel());

  addActivity() {
    activitiesCount++;
    activities.add(ActivityModel());
  }

  removeActivity() {
    if (activitiesCount > 1) {
      activitiesCount--;
      activities.removeAt(activitiesCount);
    }
  }
   Map<String, dynamic> toJson() {
    return {
      "activities_count" : activitiesCount,
      "activities" : activities.map((e) => e.toJson()),
    };
   }
}
