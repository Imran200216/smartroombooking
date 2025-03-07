import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class DatePickerProvider extends ChangeNotifier {
  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  Future<void> pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // Disable Saturdays and Sundays
        return date.weekday != DateTime.saturday &&
            date.weekday != DateTime.sunday;
      },
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.whiteColor,
              onSurface: AppColors.primaryColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      notifyListeners(); // 🔹 Updates UI immediately
    }
  }

  String get formattedDate {
    return _selectedDate != null
        ? DateFormat('dd MMM, yyyy').format(_selectedDate!)
        : "";
  }

  void clearDate() {
    _selectedDate = null;
    notifyListeners();
  }
}
