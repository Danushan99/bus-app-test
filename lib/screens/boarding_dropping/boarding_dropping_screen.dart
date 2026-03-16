import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';
import 'package:test_bus_app/screens/boarding_dropping/widgets/location_list_item.dart';

class BoardingDroppingScreen extends StatefulWidget {
  final Map<String, dynamic> busData;

  const BoardingDroppingScreen({super.key, required this.busData});

  @override
  State<BoardingDroppingScreen> createState() => _BoardingDroppingScreenState();
}

class _BoardingDroppingScreenState extends State<BoardingDroppingScreen> {
  int _selectedTabIndex = 0; // 0 for Boarding, 1 for Dropping
  int? _selectedBoardingIndex = 0; // Pre-select first item
  int? _selectedDroppingIndex;

  // Dummy Location Data based on screenshot
  final List<Map<String, String>> _boardingLocations = [
    {
      'title': 'Maruthanar Madam',
      'subtitle': 'மருதனார் மடம்',
      'time': '08:00PM',
    },
    {
      'title': 'Inuvil Sina PAllikodam',
      'subtitle': 'இணுவில் சின்னப் பள்ளிக்கூடம்',
      'time': '09:00PM',
    },
    {
      'title': 'Inuvil Periya PAllikodam',
      'subtitle': 'இணுவில் பெரிய பள்ளிக்கூடம்',
      'time': '07:30PM',
    },
    {
      'title': 'Inuvil Kovil Vasal',
      'subtitle': 'இணுவில் கோவில் வாசல்',
      'time': '10:00PM',
    },
    {
      'title': 'Inuvil Thurai Veethi',
      'subtitle': 'இணுவில் துறைவீதி',
      'time': '06:45PM',
    },
    {
      'title': 'Uppumada Lane',
      'subtitle': 'உப்புமட லேன்',
      'time': '08:15PM',
    },
    {
      'title': 'Thavady',
      'subtitle': 'தாவடி',
      'time': '09:00PM',
    },
    {
      'title': 'Kokuvil',
      'subtitle': 'கொக்குவில்',
      'time': '09:30PM',
    },
    {
      'title': 'Poonari Madam',
      'subtitle': 'பூநாறி மடம்',
      'time': '10:00PM',
    },
  ];

  final List<Map<String, String>> _droppingLocations = [
    {
      'title': 'Wellawatte',
      'subtitle': 'வெள்ளவத்தை',
      'time': '05:00AM',
    },
    {
      'title': 'Bambalapitiya',
      'subtitle': 'பம்பலப்பிட்டி',
      'time': '05:15AM',
    },
    {
      'title': 'Kollupitiya',
      'subtitle': 'கொள்ளுப்பிட்டி',
      'time': '05:30AM',
    },
    // Adding a few more generic for testing
    {
      'title': 'Pettah',
      'subtitle': 'புறக்கோட்டை',
      'time': '06:00AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocations =
        _selectedTabIndex == 0 ? _boardingLocations : _droppingLocations;
    final currentIndex = _selectedTabIndex == 0
        ? _selectedBoardingIndex
        : _selectedDroppingIndex;

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
          'Select Boarding & Dropping points',
          style: AppStyling.normal600Size14.copyWith(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Tab Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabItem(
                    index: 0,
                    title: 'Boarding Points',
                    subtitle: 'Jaffna',
                    isActive: _selectedTabIndex == 0,
                  ),
                ),
                Expanded(
                  child: _buildTabItem(
                    index: 1,
                    title: 'Dropping Points',
                    subtitle: 'Colombo',
                    isActive: _selectedTabIndex == 1,
                  ),
                ),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: AppColors.divider, width: 1.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: _selectedTabIndex == 0
                              ? 'Search Boarding Point'
                              : 'Search Dropping Point',
                          hintStyle: AppStyling.normal400Size16.copyWith(
                            color: AppColors.grey500,
                            fontSize: 15,
                          ),
                          suffixIcon:
                              Icon(Icons.search, color: Colors.grey.shade800),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                        ),
                      ),
                    ),
                  ),

                  // Location List
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      itemCount: currentLocations.length,
                      separatorBuilder: (context, index) => Divider(
                        color: AppColors.divider,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final location = currentLocations[index];
                        return LocationListItem(
                          title: location['title'] ?? '',
                          subtitle: location['subtitle'] ?? '',
                          time: location['time'] ?? '',
                          isSelected: currentIndex == index,
                          onTap: () {
                            setState(() {
                              if (_selectedTabIndex == 0) {
                                _selectedBoardingIndex = index;
                              } else {
                                _selectedDroppingIndex = index;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // Bottom padding safe area
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          context.pushNamed(
                            AppRoutesConstants.confirmationScreenRouteName,
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
                          'Continue',
                          style: AppStyling.normal600Size14.copyWith(
                            fontSize: 16,
                            color: AppColors.surfaceLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String title,
    required String subtitle,
    required bool isActive,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryVeryLight
              : AppColors.surfaceLight, // Light green BG
          borderRadius: index == 0
              ? const BorderRadius.horizontal(left: Radius.circular(16))
              : const BorderRadius.horizontal(right: Radius.circular(16)),
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: AppColors.primary, width: 2))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyling.normal500Size14.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppStyling.normal500Size14.copyWith(
                    fontSize: 13,
                    color: isActive ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
