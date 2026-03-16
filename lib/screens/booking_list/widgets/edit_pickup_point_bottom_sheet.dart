import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';

class EditPickupPointBottomSheet extends StatefulWidget {
  final String currentPickupPoint;

  const EditPickupPointBottomSheet(
      {super.key, required this.currentPickupPoint});

  @override
  State<EditPickupPointBottomSheet> createState() =>
      _EditPickupPointBottomSheetState();

  static void show(BuildContext context, String currentPickupPoint) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          EditPickupPointBottomSheet(currentPickupPoint: currentPickupPoint),
    );
  }
}

class _EditPickupPointBottomSheetState
    extends State<EditPickupPointBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedLocation;

  // Dummy data matching the screenshot
  final List<Map<String, String>> _locations = [
    {
      'name': 'Maruthanar Madam',
      'time': '08:00PM',
      'subtitle': 'மருதனார் மடம்'
    },
    {
      'name': 'Inuvil Sina PAllikodam',
      'time': '09:00PM',
      'subtitle': 'இணுவில் சின்னப் பள்ளிக்கூடம்'
    },
    {
      'name': 'Inuvil Periya PAllikodam',
      'time': '07:30PM',
      'subtitle': 'இணுவில் பெரிய பள்ளிக்கூடம்'
    },
    {
      'name': 'Inuvil Kovil Vasal',
      'time': '10:00PM',
      'subtitle': 'இணுவில் கோவில் வாசல்'
    },
    {
      'name': 'Inuvil Thurai Veethi',
      'time': '06:45PM',
      'subtitle': 'இணுவில் துறைவீதி'
    },
    {'name': 'Uppumada Lane', 'time': '08:15PM', 'subtitle': 'உப்புமட லேன்'},
    {'name': 'Thavady', 'time': '09:00PM', 'subtitle': 'தாவடி'},
    {'name': 'Kokuvil', 'time': '09:30PM', 'subtitle': 'கொக்குவில்'},
    {'name': 'Poonari Madam', 'time': '10:00PM', 'subtitle': 'பூநாறி மடம்'},
    {
      'name': 'Nachimarkovil',
      'time': '10:30PM',
      'subtitle': 'நாச்சிமார் கோவில்'
    },
    {'name': 'Maple Drive', 'time': '11:00PM', 'subtitle': 'மேப்பல் டிரைவ்'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedLocation = widget.currentPickupPoint;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Header Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.textPrimary, width: 1.5),
            ),
            child: const Icon(Icons.location_on_outlined,
                size: 28, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            'Edit Pickup Point',
            style: AppStyling.normal600Size14.copyWith(
              fontSize: 22,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            'Prevent this seat from being booked for trips.',
            style: AppStyling.normal500Size16.copyWith(
              fontSize: 15,
              color: AppColors.grey500,
            ),
          ),
          const SizedBox(height: 24),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: TextField(
                controller: _searchController,
                style: AppStyling.normal400Size16,
                decoration: InputDecoration(
                  hintText: 'Search Boarding Point',
                  hintStyle: AppStyling.normal400Size16.copyWith(
                    color: AppColors.grey400,
                  ),
                  suffixIcon:
                      Icon(Icons.search, color: AppColors.grey600, size: 24),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // List View
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: _locations.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: AppColors.divider),
                itemBuilder: (context, index) {
                  final loc = _locations[index];
                  final isSelected = _selectedLocation == loc['name'];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedLocation = loc['name'];
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.grey400,
                            size: 24,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loc['name']!,
                                  style: AppStyling.normal400Size16.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  loc['subtitle']!,
                                  style: AppStyling.normal500Size12.copyWith(
                                    color: AppColors.grey500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            loc['time']!,
                            style: AppStyling.normal500Size14.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: AppColors.grey500),
                    ),
                    child: Text(
                      'Close',
                      style: AppStyling.normal500Size16.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle update logic here
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Update',
                      style: AppStyling.normal600Size14.copyWith(
                        fontSize: 16,
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
