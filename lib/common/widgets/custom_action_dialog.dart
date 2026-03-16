import 'package:flutter/material.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';

class CustomActionDialog extends StatelessWidget {
  final Widget icon;
  final String title;
  final String description;
  final Widget? content;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final Color primaryButtonColor;
  final Color primaryButtonTextColor;

  const CustomActionDialog({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.content,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.primaryButtonColor = AppColors.errorDark, // Default to red
    this.primaryButtonTextColor = AppColors.surfaceLight,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent, // Prevents Material 3 tinting
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            icon,
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.3,
              ),
            ),

            if (content != null) ...[
              const SizedBox(height: 24),
              content!,
            ],

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onSecondaryPressed,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: const BorderSide(color: AppColors.grey500),
                    ),
                    child: Text(
                      secondaryButtonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      foregroundColor: primaryButtonTextColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      primaryButtonText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget icon,
    required String title,
    required String description,
    Widget? content,
    required String primaryButtonText,
    required String secondaryButtonText,
    required VoidCallback onPrimaryPressed,
    required VoidCallback onSecondaryPressed,
    Color primaryButtonColor = AppColors.errorDark,
    Color primaryButtonTextColor = AppColors.surfaceLight,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomActionDialog(
          icon: icon,
          title: title,
          description: description,
          content: content,
          primaryButtonText: primaryButtonText,
          secondaryButtonText: secondaryButtonText,
          onPrimaryPressed: onPrimaryPressed,
          onSecondaryPressed: onSecondaryPressed,
          primaryButtonColor: primaryButtonColor,
          primaryButtonTextColor: primaryButtonTextColor,
        );
      },
    );
  }
}
