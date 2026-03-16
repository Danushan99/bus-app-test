import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/common/widgets/app_drawer.dart';
import 'package:test_bus_app/screens/home/widgets/bus_ticket_card.dart';
import 'package:test_bus_app/screens/home/widgets/date_selector_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedDateIndex = 1;

  // Dummy Bus Data based on the selected date
  final List<List<Map<String, dynamic>>> _dailyBusData = [
    // Day 0 (Jun 12)
    [
      {
        'name': 'Kannan Travels',
        'type': 'Semi Luxury',
        'plate': 'NC-1122',
        'price': 3500,
        'deptTime': '08:00',
        'deptAmPm': 'AM',
        'deptLoc': 'Jaffna',
        'arrTime': '07:00',
        'arrAmPm': 'PM',
        'arrLoc': 'Colombo',
        'bookedSeats': 45,
        'totalSeats': 51,
      }
    ],
    // Day 1 (Jun 13) - The original screenshot data
    [
      {
        'name': 'Srimurugan',
        'type': 'Super Luxury',
        'plate': 'NH-9596',
        'price': 4500,
        'deptTime': '06:00',
        'deptAmPm': 'PM',
        'deptLoc': 'Jaffna',
        'arrTime': '05:00',
        'arrAmPm': 'AM',
        'arrLoc': 'Colombo',
        'bookedSeats': 20,
        'totalSeats': 51,
      }
    ],
    // Day 2 (Jun 14)
    [
      {
        'name': 'Yarl Express',
        'type': 'Normal',
        'plate': 'NP-4455',
        'price': 2000,
        'deptTime': '10:00',
        'deptAmPm': 'AM',
        'deptLoc': 'Jaffna',
        'arrTime': '09:00',
        'arrAmPm': 'PM',
        'arrLoc': 'Colombo',
        'bookedSeats': 51,
        'totalSeats': 51,
      },
      {
        'name': 'Srimurugan',
        'type': 'Super Luxury',
        'plate': 'NH-9597',
        'price': 4500,
        'deptTime': '08:30',
        'deptAmPm': 'PM',
        'deptLoc': 'Jaffna',
        'arrTime': '07:30',
        'arrAmPm': 'AM',
        'arrLoc': 'Colombo',
        'bookedSeats': 5,
        'totalSeats': 51,
      }
    ],
    // Day 3 (Jun 15)
    [], // No buses
    // Day 4 (Jun 16)
    [
      {
        'name': 'Weekend Special',
        'type': 'A/C Luxury',
        'plate': 'NW-9999',
        'price': 5000,
        'deptTime': '09:00',
        'deptAmPm': 'PM',
        'deptLoc': 'Jaffna',
        'arrTime': '06:00',
        'arrAmPm': 'AM',
        'arrLoc': 'Colombo',
        'bookedSeats': 30,
        'totalSeats': 40,
      }
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final currentBuses = _dailyBusData[_selectedDateIndex];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundLight,
      drawer: const AppDrawer(activeItem: 'Home'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          final name = state is Authenticated
                              ? state.user.name
                              : 'there';
                          return Text(
                            'Good Morning, $name!',
                            style: AppStyling.normal500Size16.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Jaffna - Colombo',
                            style: AppStyling.heading700Size24.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.keyboard_arrow_down,
                              size: 24, color: AppColors.grey800),
                        ],
                      ),
                    ],
                  ),

                  // Menu Button
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.menu, color: AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Dates Scroll View
            DateSelectorWidget(
              selectedIndex: _selectedDateIndex,
              onDateSelected: (index) {
                setState(() {
                  _selectedDateIndex = index;
                });
              },
            ),

            const SizedBox(height: 30),

            // Bus Ticket List
            Expanded(
              child: currentBuses.isEmpty
                  ? Center(
                      child: Text(
                        'No buses available on this date.',
                        style: AppStyling.normal500Size16.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: currentBuses.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemBuilder: (context, index) {
                        return BusTicketCard(busData: currentBuses[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
