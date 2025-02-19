import 'package:flutter/material.dart';

class UserRoleProvider extends ChangeNotifier {
  String? _selectedRole;

  String? get selectedRole => _selectedRole;

  void setSelectedRole(String value) {
    _selectedRole = value;
    notifyListeners();
  }
}
