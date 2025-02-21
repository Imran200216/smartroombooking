import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartroombooking/commons/provider/muti_selection_chip_provider.dart';
import 'package:smartroombooking/core/themes/colors/app_colors.dart';

class CustomRoomBookingSlotChips extends StatelessWidget {
  const CustomRoomBookingSlotChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MultiSelectionChipProvider>(
      builder: (context, provider, child) {
        return Wrap(
          spacing: 8.0,
          children:
              provider.timeSlots.map((slot) {
                bool isSelected = provider.selectedSlots.contains(slot);
                return FilterChip(
                  label: Text(slot),
                  labelStyle: TextStyle(
                    color:
                        isSelected
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                    fontFamily: "Redhat",
                  ),
                  selected: isSelected,
                  selectedColor: AppColors.primaryColor,
                  checkmarkColor: AppColors.whiteColor,
                  onSelected: (bool selected) {
                    provider.toggleSlot(slot);
                  },
                );
              }).toList(),
        );
      },
    );
  }
}
