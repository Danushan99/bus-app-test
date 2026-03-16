// lib/screens/seat_selection/seat_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';
import 'package:test_bus_app/screens/seat_selection/widgets/seat_widget.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> busData;

  const SeatSelectionScreen({super.key, required this.busData});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  // Mapping of seat numbers to their initial status based on the screenshot
  final Map<String, SeatStatus> _seatStatuses = {
    // Row 1
    '01': SeatStatus.ladies, '02': SeatStatus.ladies, '03': SeatStatus.selected,
    '04': SeatStatus.selected,
    // Row 2
    '05': SeatStatus.available, '06': SeatStatus.available,
    '07': SeatStatus.reserved, '08': SeatStatus.reserved,
    // Row 3
    '09': SeatStatus.available, '10': SeatStatus.available,
    '11': SeatStatus.available, '12': SeatStatus.available,
    // Row 4
    '13': SeatStatus.booked, '14': SeatStatus.booked,
    '15': SeatStatus.available, '16': SeatStatus.available,
    // Row 5
    '17': SeatStatus.available, '18': SeatStatus.booked,
    '19': SeatStatus.available, '20': SeatStatus.available,
    // Row 6
    '21': SeatStatus.available, '22': SeatStatus.available,
    '23': SeatStatus.available, '24': SeatStatus.available,
    // Row 7
    '25': SeatStatus.available, '26': SeatStatus.booked,
    '27': SeatStatus.available, '28': SeatStatus.available,
    // Row 8
    '29': SeatStatus.available, '30': SeatStatus.available,
    '31': SeatStatus.available, '32': SeatStatus.available,
    // Row 9
    '33': SeatStatus.available, '34': SeatStatus.available,
    '35': SeatStatus.available, '36': SeatStatus.available,
    // Row 10
    '37': SeatStatus.available, '38': SeatStatus.available,
    '39': SeatStatus.available, '40': SeatStatus.available,
    // Row 11 (Back row, 5 seats)
    '41': SeatStatus.available,
    '42': SeatStatus.available,
    '43': SeatStatus.available,
    '44': SeatStatus.available,
    '45': SeatStatus.available,
  };

  final List<String> _selectedSeats = [
    '03',
    '04'
  ]; // Initially matching the UI mock selected seats

  void _toggleSeat(String seatNumber) {
    setState(() {
      final currentStatus = _seatStatuses[seatNumber];

      if (currentStatus == SeatStatus.booked) return;

      if (currentStatus == SeatStatus.selected) {
        // Unselect (reverting to available, though logic implies it goes back to original state, we'll assume available)
        _seatStatuses[seatNumber] = SeatStatus.available;
        _selectedSeats.remove(seatNumber);
      } else {
        // Select
        _seatStatuses[seatNumber] = SeatStatus.selected;
        _selectedSeats.add(seatNumber);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Generate layout rows based on screenshot
    // Each row list has up to 3 segments: left seats, right seats.
    // Format: [[left1, left2], [right1, right2]]
    // Last row has 5 seats: [[1, 2, 3, 4, 5]]
    final List<List<List<String>>> seatLayout = [
      [
        ['01', '02'],
        ['03', '04']
      ],
      [
        ['05', '06'],
        ['07', '08']
      ],
      [
        ['09', '10'],
        ['11', '12']
      ],
      [
        ['13', '14'],
        ['15', '16']
      ],
      [
        ['17', '18'],
        ['19', '20']
      ],
      [
        ['21', '22'],
        ['23', '24']
      ],
      [
        ['25', '26'],
        ['27', '28']
      ],
      [
        ['29', '30'],
        ['31', '32']
      ],
      [
        ['33', '34'],
        ['35', '36']
      ],
      [
        ['37', '38'],
        ['39', '40']
      ],
      [
        ['41', '42', '43', '44', '45']
      ], // Back row
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Select Your Seat',
          style: AppStyling.normal600Size14.copyWith(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.busData['name'] ?? 'Srimurugan',
                      style: AppStyling.normal600Size14.copyWith(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jaffna - Colombo',
                      style: AppStyling.normal500Size16.copyWith(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.busData['deptTime'] != null
                          ? '${widget.busData['deptTime']} ${widget.busData['deptAmPm']}'
                          : '06:30 PM',
                      style: AppStyling.normal600Size14.copyWith(
                        color: AppColors.primary,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jun 13, 2026',
                      style: AppStyling.normal500Size16.copyWith(
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Seating Grid
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: seatLayout.map((rowSeats) {
                    if (rowSeats.length == 1) {
                      // Back row (5 seats)
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: rowSeats[0].map((seatId) {
                            return SeatWidget(
                              seatNumber:
                                  seatId.length == 2 && seatId.startsWith('0')
                                      ? seatId
                                      : seatId, // Keep format like 01
                              status:
                                  _seatStatuses[seatId] ?? SeatStatus.available,
                              onTap: () => _toggleSeat(seatId),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      // Normal row (2 left, space, 2 right)
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Seats
                            Row(
                              children: [
                                SeatWidget(
                                  seatNumber: rowSeats[0][0],
                                  status: _seatStatuses[rowSeats[0][0]] ??
                                      SeatStatus.available,
                                  onTap: () => _toggleSeat(rowSeats[0][0]),
                                ),
                                const SizedBox(width: 12),
                                SeatWidget(
                                  seatNumber: rowSeats[0][1],
                                  status: _seatStatuses[rowSeats[0][1]] ??
                                      SeatStatus.available,
                                  onTap: () => _toggleSeat(rowSeats[0][1]),
                                ),
                              ],
                            ),
                            // Aisle gap handled by spaceBetween, or empty box

                            // Right Seats
                            Row(
                              children: [
                                SeatWidget(
                                  seatNumber: rowSeats[1][0],
                                  status: _seatStatuses[rowSeats[1][0]] ??
                                      SeatStatus.available,
                                  onTap: () => _toggleSeat(rowSeats[1][0]),
                                ),
                                const SizedBox(width: 12),
                                SeatWidget(
                                  seatNumber: rowSeats[1][1],
                                  status: _seatStatuses[rowSeats[1][1]] ??
                                      SeatStatus.available,
                                  onTap: () => _toggleSeat(rowSeats[1][1]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  }).toList(),
                ),
              ),
            ),
          ),

          // Bottom Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: const BoxDecoration(
              color: AppColors.surfaceLight,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSeats.isEmpty
                          ? 'No seat selected'
                          : _selectedSeats.map((s) => '1M($s)').join(', '),
                      style: AppStyling.normal600Size14.copyWith(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'LKR ${(widget.busData['price'] ?? 2800) * _selectedSeats.length}.00',
                      style: AppStyling.normal600Size14.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: _selectedSeats.isEmpty
                        ? null
                        : () {
                            context.pushNamed(
                              AppRoutesConstants
                                  .boardingDroppingScreenRouteName,
                              extra: widget.busData,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: AppStyling.normal600Size14.copyWith(
                        fontSize: 16,
                        color: AppColors.surfaceLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
