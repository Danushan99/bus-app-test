import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';

enum SeatStatus { available, booked, selected, ladies, reserved }

class SeatWidget extends StatelessWidget {
  final String seatNumber;
  final SeatStatus status;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.seatNumber,
    required this.status,
    required this.onTap,
  });

  Color _getSeatColor() {
    switch (status) {
      case SeatStatus.available:
        return AppColors.grey800; // Dark Grey
      case SeatStatus.booked:
        return AppColors.grey400; // Light Grey
      case SeatStatus.selected:
        return AppColors.primary; // Primary Green
      case SeatStatus.ladies:
        return AppColors.ladiesSeat; // Pink
      case SeatStatus.reserved:
        return AppColors.errorDark; // Dark Red
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getSeatColor();
    final isSelected = status == SeatStatus.selected;

    return GestureDetector(
      onTap: status == SeatStatus.booked ? null : onTap,
      child: Container(
        width: 44,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer Seat Structure (Armrests and back)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: color, width: 2.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
              ),
            ),

            // Inner Seat Cushion
            Positioned(
              top: 8,
              bottom: 4,
              left: 6,
              right: 6,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.1)
                      : Colors.transparent,
                  border: Border.all(color: color, width: 2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  seatNumber,
                  style: AppStyling.normal600Size14.copyWith(
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
