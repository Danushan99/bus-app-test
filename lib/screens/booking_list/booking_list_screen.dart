import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/screens/booking_list/widgets/booking_list_item_widget.dart';

class BookingListScreen extends StatefulWidget {
  final Map<String, dynamic> busData;

  const BookingListScreen({super.key, required this.busData});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Booking List',
          style: AppStyling.normal600Size14.copyWith(
            color: AppColors.textPrimary,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            color: AppColors.surfaceLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.busData['name'] ?? 'Srimurugan',
                      style: AppStyling.normal500Size16.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${widget.busData['deptLoc'] ?? "Jaffna"} - ${widget.busData['arrLoc'] ?? "Colombo"}',
                      style: AppStyling.normal400Size16.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.busData['deptTime'] ?? "06:30"} ${widget.busData['deptAmPm'] ?? "PM"}',
                      style: AppStyling.normal500Size16.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jun 13, 2026',
                      style: AppStyling.normal400Size16.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Section
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Search Boarding Point',
                        hintStyle: AppStyling.normal400Size16.copyWith(
                          color: AppColors.grey500,
                        ),
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.search,
                              color: AppColors.textPrimary, size: 24),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.filter_list,
                      color: AppColors.textPrimary, size: 24),
                ),
              ],
            ),
          ),

          // Booking List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 2,
              itemBuilder: (context, index) {
                return BookingListItemWidget(
                  isUnpaid: index == 0,
                  busData: widget.busData,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
