// lib/screens/confirmation/widgets/ticket_card_widget.dart

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/screens/confirmation/widgets/ticket_cutout_clipper.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';

class TicketCardWidget extends StatelessWidget {
  final Map<String, dynamic> busData;
  final List<String> selectedSeats;

  const TicketCardWidget({
    super.key,
    required this.busData,
    required this.selectedSeats,
  });

  @override
  Widget build(BuildContext context) {
    final ticketPrice = busData['price'] ?? 2800;
    final totalPrice = ticketPrice * selectedSeats.length;

    return ClipPath(
      clipper: TicketCutoutClipper(
        holeRadius: 15,
        holeYOffset: 317, // Adjusted height for more accuracy with design
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TOP GREEN SECTION
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              decoration: const BoxDecoration(
                color: AppColors.primary, // Primary Green
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        busData['name'] ?? 'Sri Murugan',
                        style: AppStyling.normal600Size14.copyWith(
                          fontSize: 22,
                          color: AppColors.surfaceLight,
                        ),
                      ),
                      Text(
                        busData['deptTime'] != null
                            ? '${busData['deptTime']} ${busData['deptAmPm']}'
                            : '06:30 PM',
                        style: AppStyling.normal500Size14.copyWith(
                          fontSize: 22,
                          color: AppColors.surfaceLight,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24, height: 1),
                  const SizedBox(height: 16),

                  // Route Details Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Boarding
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Maruthanar Madam', // From dummy data or mock
                            style: AppStyling.normal500Size12.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'JAF',
                            style: AppStyling.normal700Size14.copyWith(
                              color: AppColors.surfaceLight,
                              fontSize: 48,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '07:30 PM',
                            style: AppStyling.normal600Size14.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Mon, Jun 14g',
                            style: AppStyling.normal400Size13.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        ],
                      ),

                      // Dashed line connector
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TicketDashedDivider(
                            color: AppColors.surfaceLight.withValues(alpha: 0.5),
                            height: 2,
                          ),
                        ),
                      ),

                      // Dropping
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Wellawatte Market',
                            style: AppStyling.normal500Size12.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'COL',
                            style: AppStyling.normal700Size14.copyWith(
                              color: AppColors.surfaceLight,
                              fontSize: 48,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '03:30 AM',
                            style: AppStyling.normal600Size14.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Mon, Jun 15',
                            style: AppStyling.normal400Size13.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: Colors.white24, height: 1),
                  const SizedBox(height: 16),

                  // Seats and Total Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Seats',
                            style: AppStyling.normal600Size14.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            selectedSeats.isEmpty
                                ? 'None'
                                : selectedSeats.map((s) => '1M($s)').join(', '),
                            style: AppStyling.normal400Size22.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Total ($ticketPrice*${selectedSeats.length})',
                            style: AppStyling.normal600Size14.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'LKR $totalPrice.00',
                            style: AppStyling.normal400Size22.copyWith(
                              color: AppColors.surfaceLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ACTION ICONS ROW (Darker Green styling)
            Container(
              height: 52,
              decoration: const BoxDecoration(
                color: AppColors.primaryDark, // Slightly darker green
              ),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.money, color: AppColors.surfaceLight),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.add_box_outlined,
                          color: AppColors.surfaceLight),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon:
                          const Icon(Icons.edit_outlined, color: AppColors.surfaceLight),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      icon: const Icon(Icons.more_vert, color: AppColors.surfaceLight),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM GREY SECTION (Barcode)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              decoration: const BoxDecoration(
                color: AppColors.divider, // Light Grey Bottom (was grey300/E0E0E0)
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: BarcodeWidget(
                      barcode: Barcode.code128(), // Barcode type
                      data: 'Ticket id: 234509875',
                      drawText: true,
                      style: AppStyling.normal600Size12.copyWith(
                        fontSize: 11,
                        color: AppColors.textPrimary,
                      ),
                      textPadding: 8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
