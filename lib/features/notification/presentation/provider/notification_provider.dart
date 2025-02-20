import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isNotificationEnabled = false;

  bool get isNotificationEnabled => _isNotificationEnabled;

  void toggleNotification(bool value) {
    _isNotificationEnabled = value;
    notifyListeners();
  }
}
