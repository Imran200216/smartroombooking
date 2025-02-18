import 'package:flutter/material.dart';

class OnBoardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onBoardingData = [
    {
      "image": "on-boarding-img-1",
      "title": "Effortless Room Booking",
      "subtitle":
          "Easily book study rooms, meeting halls, and lecture spaces in just a few taps. No more last-minute hassle—reserve your spot anytime, anywhere!",
    },
    {
      "image": "on-boarding-img-2",
      "title": "Smart Schedule Management",
      "subtitle":
          "Stay organized with automated reminders and scheduling. Never miss an important session or meeting!",
    },
    {
      "image": "on-boarding-img-3",
      "title": "Secure & Accessible for Everyone",
      "subtitle":
          "Designed for students, faculty, and staff with a secure login system and role-based access.",
    },
  ];

  void updatePage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void skipToLastPage() {
    pageController.jumpToPage(onBoardingData.length - 1);
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < onBoardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // Navigate to the next screen (e.g., Login or Home)
    }
    notifyListeners();
  }
}
