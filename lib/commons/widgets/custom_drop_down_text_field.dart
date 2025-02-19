import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomDropdownTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final bool hasBorder;
  final FormFieldValidator<String>? validator;

  const CustomDropdownTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.hasBorder = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      validator: validator,
      decoration: InputDecoration(
        fillColor: AppColors.whiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide:
              hasBorder
                  ? BorderSide(
                    color: AppColors.outlinedBtnBorderColor,
                    width: 1,
                  )
                  : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide:
              hasBorder
                  ? BorderSide(
                    color: AppColors.outlinedBtnBorderColor,
                    width: 1,
                  )
                  : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide:
              hasBorder
                  ? BorderSide(color: AppColors.primaryColor, width: 1.5)
                  : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.errorTextFieldColor,
            width: 1,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: "RedHat",
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          color: AppColors.textFieldHintColor,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.titleColor),
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        errorStyle: TextStyle(
          fontFamily: "RedHat",
          color: AppColors.errorTextFieldColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: TextStyle(
        fontFamily: "RedHat",
        fontWeight: FontWeight.w600,
        fontSize: 13.sp,
        color: AppColors.titleColor,
      ),
      icon: Icon(Icons.arrow_drop_down, color: AppColors.textFieldHintColor),
      items:
          items.map((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      onChanged: onChanged,
    );
  }
}
