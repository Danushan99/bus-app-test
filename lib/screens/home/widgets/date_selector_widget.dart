import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';

class DateSelectorWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onDateSelected;

  const DateSelectorWidget({
    super.key,
    required this.selectedIndex,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy Data Array matched to indices
    final dates = [
      {'day': 'Mon', 'date': 'Jun 12'},
      {'day': 'Tue', 'date': 'Jun 13'},
      {'day': 'Wed', 'date': 'Jun 14', 'icon': Icons.wb_sunny_outlined},
      {'day': 'Thu', 'date': 'Jun 15'},
      {'day': 'Fri', 'date': 'Jun 16'},
    ];

    return SizedBox(
      height: 70,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = dates[index];
          final isActive = index == selectedIndex;

          return GestureDetector(
            onTap: () => onDateSelected(index),
            child: Container(
              width: 70,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isActive)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['day'] as String,
                        style: AppStyling.normal500Size14.copyWith(
                          fontSize: 13,
                          color: isActive ? AppColors.surfaceLight : AppColors.textPrimary,
                        ),
                      ),
                      if (item['icon'] != null) ...[
                        const SizedBox(width: 4),
                        Icon(
                          item['icon'] as IconData,
                          size: 10,
                          color: isActive ? AppColors.surfaceLight : AppColors.textSecondary,
                        )
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['date'] as String,
                        style: AppStyling.normal600Size14.copyWith(
                          color: isActive ? AppColors.surfaceLight : AppColors.textPrimary,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(width: 2),
                        const Icon(Icons.keyboard_arrow_down,
                            size: 14, color: AppColors.surfaceLight),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
