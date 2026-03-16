// lib/screens/boarding_dropping/widgets/location_list_item.dart

import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';

class LocationListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const LocationListItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Radio button custom icon
            Container(
              margin: const EdgeInsets.only(top: 2, right: 16),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                  width: isSelected ? 5.5 : 1.5,
                ),
              ),
            ),

            // Text Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyling.normal500Size16.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppStyling.normal400Size12.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Time
            Text(
              time,
              style: AppStyling.normal600Size14.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
