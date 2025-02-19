import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomUserTypeCheckBoxListTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomUserTypeCheckBoxListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.subTitleColor, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color:
            value ? AppColors.successCheckBoxTileBgColor : Colors.transparent,
        child: CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(vertical: -4.h, horizontal: 10),
          // ✅ Reduces padding to shrink height
          visualDensity: VisualDensity.compact,
          // ✅ Makes the tile smaller
          checkboxShape: CircleBorder(),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Redhat",
              fontWeight: FontWeight.w600,
              color: value ? AppColors.whiteColor : AppColors.titleColor,
              fontSize: 14.sp, // ✅ Slightly reduce font size
            ),
          ),
          activeColor: AppColors.whiteColor,
          checkColor: AppColors.successCheckBoxTileBgColor,
          value: value,
          onChanged: onChanged,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
