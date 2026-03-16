// lib/screens/confirmation/confirmation_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/common/widgets/app_button.dart';
import 'package:test_bus_app/screens/confirmation/widgets/ticket_card_widget.dart';

class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> busData;
  final List<String> selectedSeats;

  const ConfirmationScreen({
    super.key,
    required this.busData,
    this.selectedSeats = const ['03', '04'], // Defaulting for visual test
  });

  @override
  Widget build(BuildContext context) {
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
          'Confirmation',
          style: AppStyling.normal600Size14.copyWith(
            color: AppColors.textPrimary,
            fontSize: 16,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // The Ticket Card
                    TicketCardWidget(
                      busData: busData,
                      selectedSeats: selectedSeats,
                    ),

                    const SizedBox(height: 30),

                    // Phone Number Input
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 6),
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
                          Text(
                            '+94',
                            style: AppStyling.normal500Size16.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: AppStyling.normal400Size16.copyWith(
                                  color: AppColors.grey400,
                                ),
                                border: InputBorder.none,
                              ),
                              style: AppStyling.normal500Size16,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Confirm Button Bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: AppButton(
                label: 'Confirm',
                onPressed: () {
                  // Final submission logic
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
