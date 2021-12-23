import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourismapp/models/day_model.dart';

class AddTripController extends GetxController {
  final PageController _pageController = PageController();
  final List<DayModel> _itinerary = [DayModel()];
  int _daysCount = 1;
  int _currentPage = 0;

  DayModel get currentDay => _itinerary[currentPage];

  bool get isFirstPage => currentPage == 0;

  bool get isLastPage => currentPage == daysCount - 1;

  int get daysCount => _daysCount;

  int get currentPage => _currentPage;

  PageController get pageController => _pageController;

  Future<void> goToPreviousPage() async {
    if (!isFirstPage) {
      _currentPage--;
      await _pageController.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
      update();
    }
  }

  Future<void> goToNextPage() async {
    if (!isLastPage) {
      _currentPage++;
      await _pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
      update();
    } else {
      print(_itinerary.map((e) => e.toJson()));
    }
  }

  void decrementDaysCount() {
    if (_daysCount > 1) {
      _daysCount--;
      _itinerary.removeLast();
      update();
    }
  }

  void incrementDaysCount() {
    _daysCount++;
    _itinerary.add(DayModel());
    update();
  }

  void addActivityToCurrentDay() {
    currentDay.addActivity();
    update();
  }

  void removeActivityFromCurrentDay() {
    currentDay.removeActivity();
    update();
  }
}
