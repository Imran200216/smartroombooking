import 'package:flutter/material.dart';

class MultiSelectionChipProvider extends ChangeNotifier {
  final List<String> timeSlots = [
    "9:00 AM",
    "9:50 AM",
    "10:50 AM",
    "11:40 AM",
    "1:30 PM",
    "2:20 PM",
    "3:10 PM",
  ];

  final Set<String> _selectedSlots = {};

  Set<String> get selectedSlots => _selectedSlots;

  void toggleSlot(String slot) {
    if (_selectedSlots.contains(slot)) {
      _selectedSlots.remove(slot);
    } else {
      _selectedSlots.add(slot);
    }
    notifyListeners();
  }
}
