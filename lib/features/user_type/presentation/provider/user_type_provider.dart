import 'package:flutter/material.dart';

class UserTypeProvider extends ChangeNotifier {
  bool _isStaff = false;
  bool _isAdmin = false;

  bool get isStaff => _isStaff;
  bool get isAdmin => _isAdmin;

  void toggleStaff(bool value) {
    _isStaff = value;
    if (value) _isAdmin = false;
    notifyListeners();
  }

  void toggleAdmin(bool value) {
    _isAdmin = value;
    if (value) _isStaff = false;
    notifyListeners();
  }
}
