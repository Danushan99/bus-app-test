import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/common/widgets/custom_action_dialog.dart';
import 'package:test_bus_app/screens/booking_list/widgets/edit_pickup_point_bottom_sheet.dart';

class BookingListItemWidget extends StatelessWidget {
  final bool isUnpaid;
  final Map<String, dynamic> busData;

  const BookingListItemWidget({
    super.key,
    required this.isUnpaid,
    required this.busData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isUnpaid ? AppColors.primaryVeryLight : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Seats and Price
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 12, 12),
            child: Row(
              children: [
                const Icon(Icons.event_seat_outlined,
                    size: 24, color: AppColors.textPrimary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isUnpaid ? '1(M) 3(M) 5(M)' : '2(M)',
                    style: AppStyling.normal500Size16.copyWith(
                      fontSize: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Text(
                  'LKR 8400',
                  style: AppStyling.normal500Size16.copyWith(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 4),
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  color: AppColors.surfaceLight,
                  elevation: 4,
                  onSelected: (value) {
                    if (value == 'Edit Pickup Point') {
                      EditPickupPointBottomSheet.show(
                          context, 'Maruthanar Madam');
                    } else if (value == 'Note') {
                      CustomActionDialog.show(
                        context: context,
                        icon: const Icon(Icons.edit_note_outlined,
                            size: 48, color: AppColors.textPrimary),
                        title: 'Add Note',
                        description:
                            'Temporarily prevent this bus from\naccepting new bookings.',
                        content: TextField(
                          decoration: InputDecoration(
                            hintText: 'Add Note',
                            hintStyle: const TextStyle(
                                color: AppColors.grey400, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                        primaryButtonText: 'Add',
                        secondaryButtonText: 'Cancel',
                        primaryButtonColor: AppColors.primary,
                        primaryButtonTextColor: AppColors.textPrimary,
                        onPrimaryPressed: () => Navigator.pop(context),
                        onSecondaryPressed: () => Navigator.pop(context),
                      );
                    } else if (value == 'Cancel Seat') {
                      CustomActionDialog.show(
                        context: context,
                        icon: SizedBox(
                          width: 48,
                          height: 48,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(
                                  Icons.airline_seat_recline_extra_outlined,
                                  size: 48,
                                  color: AppColors.textPrimary),
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.surfaceLight,
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(Icons.close,
                                      size: 20, color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: 'Cancel the Seat',
                        description:
                            'Temporarily prevent this bus from accepting\nnew bookings.',
                        content: Column(
                          children: [
                            _buildCheckboxItem('1M(38)', false),
                            const SizedBox(height: 8),
                            _buildCheckboxItem('1M(38)', true),
                            const SizedBox(height: 8),
                            _buildCheckboxItem('1M(38)', false),
                          ],
                        ),
                        primaryButtonText: 'Cancel Seat',
                        secondaryButtonText: 'Close',
                        primaryButtonColor: AppColors.errorDark,
                        onPrimaryPressed: () => Navigator.pop(context),
                        onSecondaryPressed: () => Navigator.pop(context),
                      );
                    } else if (value == 'Edit Seat Price') {
                      CustomActionDialog.show(
                        context: context,
                        icon: const Icon(Icons.payments_outlined,
                            size: 48, color: AppColors.textPrimary),
                        title: 'Edit Seat Price',
                        description:
                            'Temporarily prevent this bus from\naccepting new bookings.',
                        content: TextField(
                          decoration: InputDecoration(
                            hintText: 'LKR 1800.00',
                            hintStyle: const TextStyle(
                                color: AppColors.textPrimary, fontSize: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: AppColors.divider),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                          ),
                        ),
                        primaryButtonText: 'Add',
                        secondaryButtonText: 'Close',
                        primaryButtonColor: AppColors.primary,
                        primaryButtonTextColor: AppColors.textPrimary,
                        onPrimaryPressed: () => Navigator.pop(context),
                        onSecondaryPressed: () => Navigator.pop(context),
                      );
                    } else if (value == 'Edit Luggage') {
                      CustomActionDialog.show(
                        context: context,
                        icon: SizedBox(
                          width: 48,
                          height: 48,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.business_center_outlined,
                                  size: 48, color: AppColors.textPrimary),
                              Positioned(
                                right: -4,
                                top: -4,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: AppColors.surfaceLight,
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(2),
                                  child: const Icon(Icons.add,
                                      size: 20, color: AppColors.textPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: 'Edit Luggage',
                        description:
                            'Temporarily prevent this bus from\naccepting new bookings.',
                        content: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Size',
                                hintStyle: TextStyle(
                                  color: AppColors.grey400, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: AppColors.divider),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: AppColors.divider),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Payment',
                                hintStyle: TextStyle(
                                  color: AppColors.grey400, fontSize: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: AppColors.divider),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      const BorderSide(color: AppColors.divider),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                              ),
                            ),
                          ],
                        ),
                        primaryButtonText: 'Add',
                        secondaryButtonText: 'Close',
                        primaryButtonColor: AppColors.primary,
                        primaryButtonTextColor: AppColors.textPrimary,
                        onPrimaryPressed: () => Navigator.pop(context),
                        onSecondaryPressed: () => Navigator.pop(context),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Edit Pickup Point',
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined,
                              size: 20, color: AppColors.textPrimary),
                          const SizedBox(width: 12),
                          Text('Edit Pickup Point',
                              style: AppStyling.normal400Size16),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Note',
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(Icons.edit_note_outlined,
                              size: 20, color: AppColors.textPrimary),
                          const SizedBox(width: 12),
                          Text('Note', style: AppStyling.normal400Size16),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Cancel Seat',
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(Icons.event_busy_outlined,
                              size: 20, color: AppColors.textPrimary),
                          const SizedBox(width: 12),
                          Text('Cancel Seat', style: AppStyling.normal400Size16),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Edit Seat Price',
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(Icons.payments_outlined,
                              size: 20, color: AppColors.textPrimary),
                          const SizedBox(width: 12),
                          Text('Edit Seat Price',
                              style: AppStyling.normal400Size16),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Edit Luggage',
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(Icons.business_center_outlined,
                              size: 20, color: AppColors.textPrimary),
                          const SizedBox(width: 12),
                          Text('Edit Luggage', style: AppStyling.normal400Size16),
                        ],
                      ),
                    ),
                  ],
                  offset: const Offset(0, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                    child: const Icon(Icons.more_vert, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),

          const Divider(
              height: 1, color: AppColors.textPrimary, indent: 16, endIndent: 16),

          // Bottom Section: Timeline and Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline Column
                SizedBox(
                  width: 30,
                  child: Column(
                    children: [
                      Icon(
                        isUnpaid
                            ? Icons.check_circle
                            : Icons.location_on_outlined,
                        color:
                            isUnpaid ? AppColors.primary : AppColors.textPrimary,
                        size: 24,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 1,
                        height: 35,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 2),
                      const Icon(Icons.phone_outlined,
                          color: AppColors.textPrimary, size: 20),
                      const SizedBox(height: 18),
                      const Icon(Icons.person_outline,
                          color: AppColors.textPrimary, size: 20),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Text Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isUnpaid ? 'Picked up' : 'Pickup',
                                style: const TextStyle(
                                    color: AppColors.grey500, fontSize: 13),
                              ),
                              Text(
                                'Maruthanar Madam',
                                style: AppStyling.normal400Size16.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '07:30 PM',
                            style: AppStyling.normal600Size14.copyWith(
                              color: const Color(0xFF7ED321),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '+94 77 123 4567',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              isUnpaid
                                  ? 'Bus Seat'
                                  : 'Annai Muthumari Travels Colombo',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isUnpaid
                                    ? Colors.red
                                    : const Color(0xFF7ED321),
                                width: 1.2,
                              ),
                              color: isUnpaid
                                  ? Colors.transparent
                                  : const Color(0xFFF7FCEF),
                            ),
                            child: Text(
                              isUnpaid ? 'Unpaid' : 'Paid',
                              style: TextStyle(
                                color: isUnpaid
                                    ? Colors.red
                                    : const Color(0xFF7ED321),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxItem(String label, bool isChecked) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryVeryLight, // Light green tint based on screenshot
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked ? AppColors.primary : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color:
                    isChecked ? AppColors.primary : AppColors.divider,
              ),
            ),
            child: isChecked
                ? const Icon(Icons.check, size: 16, color: AppColors.surfaceLight)
                : null,
          ),
        ],
      ),
    );
  }
}
