// lib/screens/home/widgets/bus_ticket_card.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';
import 'package:test_bus_app/common/widgets/custom_action_dialog.dart';

class BusTicketCard extends StatelessWidget {
  final Map<String, dynamic> busData;

  const BusTicketCard({super.key, required this.busData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    busData['name'] as String,
                    style: AppStyling.normal600Size14.copyWith(
                      fontSize: 22,
                      color: AppColors.textPrimary,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${busData['type']}  \u2022  ${busData['plate']}',
                    style: AppStyling.normal500Size14.copyWith(
                      fontSize: 13,
                      color: AppColors.grey600,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2, right: 2),
                    child: Text(
                      'LKR',
                      style: AppStyling.normal600Size12.copyWith(
                        color: AppColors.primary.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  Text(
                    '${busData['price']}',
                    style: AppStyling.heading700Size24.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: 20),

          // Time and Location Array
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Departure
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        busData['deptTime'] as String,
                        style: AppStyling.normal500Size14.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        busData['deptAmPm'] as String,
                        style: AppStyling.normal500Size14.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    busData['deptLoc'] as String,
                    style: AppStyling.normal500Size14.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),

              // Bus Icon & Capacity
              Column(
                children: [
                  Icon(Icons.directions_bus_outlined,
                      color: AppColors.grey600, size: 20),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        height: 1,
                        width: 30,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${busData['bookedSeats']}',
                        style: AppStyling.normal700Size14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        ' / ${busData['totalSeats']}',
                        style: AppStyling.normal600Size14.copyWith(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 1,
                        width: 30,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ],
              ),

              // Arrival
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        busData['arrTime'] as String,
                        style: AppStyling.normal500Size14.copyWith(
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        busData['arrAmPm'] as String,
                        style: AppStyling.normal500Size14.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    busData['arrLoc'] as String,
                    style: AppStyling.normal500Size14.copyWith(
                      color: AppColors.grey800,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Action Buttons Bottom Row
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutesConstants.seatSelectionScreenRouteName,
                      extra: busData,
                    );
                  },
                  child: _buildActionButton(
                      Icons.event_seat_outlined, 'Booking',
                      isAdd: true),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(
                    Icons.event_busy_outlined, 'Cancellation',
                    isRemove: true),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildActionButton(Icons.assignment_outlined, 'Chart',
                    hasCheck: true),
              ),
              const SizedBox(width: 8),
              _buildMoreButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label,
      {bool isAdd = false, bool isRemove = false, bool hasCheck = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, size: 22, color: AppColors.textPrimary),
              if (isAdd)
                const Positioned(
                  right: -4,
                  top: -2,
                  child: Icon(Icons.add, size: 10, color: AppColors.textPrimary),
                ),
              if (isRemove)
                const Positioned(
                  right: -4,
                  top: -2,
                  child: Icon(Icons.close, size: 10, color: AppColors.textPrimary),
                ),
              if (hasCheck)
                const Positioned(
                  right: -4,
                  bottom: -2,
                  child: Icon(Icons.check, size: 10, color: AppColors.textPrimary),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppStyling.normal500Size11.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreButton(BuildContext context) {
    return PopupMenuButton<String>(
      padding: EdgeInsets.zero,
      color: Colors.white,
      elevation: 4,
      onSelected: (value) {
        if (value == 'See Bookings') {
          context.pushNamed(
            AppRoutesConstants.bookingListScreenRouteName,
            extra: busData,
          );
        } else if (value == 'Block this bus') {
          CustomActionDialog.show(
            context: context,
            icon: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.directions_bus_outlined,
                      size: 48, color: AppColors.textPrimary),
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.block,
                          size: 20, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            title: 'Block This Bus',
            description:
                'Temporarily prevent this bus from\naccepting new bookings.',
            primaryButtonText: 'Block',
            secondaryButtonText: 'Cancel',
            onPrimaryPressed: () => Navigator.of(context).pop(), // Close dialog
            onSecondaryPressed: () =>
                Navigator.of(context).pop(), // Close dialog
          );
        } else if (value == 'Block seat') {
          CustomActionDialog.show(
            context: context,
            icon: SizedBox(
              width: 48,
              height: 48,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.airline_seat_recline_extra_outlined,
                      size: 48, color: AppColors.textPrimary),
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceLight,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const Icon(Icons.block,
                          size: 20, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            title: 'Block Seat',
            description:
                'Temporarily prevent this seat from\naccepting new bookings.',
            primaryButtonText: 'Block',
            secondaryButtonText: 'Cancel',
            onPrimaryPressed: () => Navigator.of(context).pop(), // Close dialog
            onSecondaryPressed: () =>
                Navigator.of(context).pop(), // Close dialog
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'Block this bus',
          height: 56,
          child: Row(
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.directions_bus_outlined,
                        size: 26, color: AppColors.textPrimary),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceLight,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(1.5),
                        child: const Icon(Icons.block,
                            size: 14, color: AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Block this bus',
                style: AppStyling.normal400Size16.copyWith(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: 'Block seat',
          height: 56,
          child: Row(
            children: [
              SizedBox(
                width: 26,
                height: 26,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.airline_seat_recline_extra_outlined,
                        size: 26, color: Colors.black87),
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(1.5),
                        child: const Icon(Icons.block,
                            size: 14, color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Block seat',
                style: AppStyling.normal400Size16.copyWith(
                  fontSize: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(height: 1),
        PopupMenuItem(
          value: 'See Bookings',
          height: 56,
          child: Row(
            children: [
              SizedBox(
                  width: 26,
                  child: Icon(Icons.list_alt, size: 26, color: Colors.black87)),
              SizedBox(width: 16),
              Text(
                'See Bookings',
                style: AppStyling.normal400Size16.copyWith(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
      offset: const Offset(0, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 48,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.more_vert, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
