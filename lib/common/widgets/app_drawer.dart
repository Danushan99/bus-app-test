import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_bus_app/bloc/auth/auth_bloc.dart';
import 'package:test_bus_app/bloc/auth/auth_event.dart';
import 'package:test_bus_app/bloc/auth/auth_state.dart';
import 'package:test_bus_app/common/constants/app_colors.dart';
import 'package:test_bus_app/common/themes/app_styling.dart';
import 'package:test_bus_app/models/user/user_model.dart';
import 'package:test_bus_app/routes/app_routes_constants.dart';

class AppDrawer extends StatelessWidget {
  final String activeItem;

  const AppDrawer({super.key, this.activeItem = 'Home'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surfaceLight,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 16),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            // User Section
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final user = state is Authenticated ? state.user : null;
                return _UserSection(user: user);
              },
            ),

            const SizedBox(height: 8),

            const Divider(color: AppColors.grey300, thickness: 1, height: 24),

            // Nav Items
            _DrawerItem(
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              label: 'Home',
              isActive: activeItem == 'Home',
              onTap: () {
                Navigator.of(context).pop();
                context.goNamed(AppRoutesConstants.homeScreenRouteName);
              },
            ),
            _DrawerItem(
              icon: Icons.confirmation_number_outlined,
              activeIcon: Icons.confirmation_number_rounded,
              label: 'My Bookings',
              isActive: activeItem == 'My Bookings',
              onTap: () {
                Navigator.of(context).pop();
                context.goNamed(AppRoutesConstants.bookingListScreenRouteName);
              },
            ),
            _DrawerItem(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
              isActive: activeItem == 'Profile',
              onTap: () {
                Navigator.of(context).pop();
                context.goNamed(AppRoutesConstants.profileScreenRouteName);
              },
            ),

            const Spacer(),

            // Logout
            _DrawerItem(
              icon: Icons.logout_rounded,
              activeIcon: Icons.logout_rounded,
              label: 'Logout',
              isActive: false,
              iconColor: AppColors.error,
              labelColor: AppColors.error,
              onTap: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LogoutRequested());
              },
            ),

            const SizedBox(height: 16),

            // Footer
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Powered By',
                      style: AppStyling.normal500Size16.copyWith(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'iCODE Mobility Solution',
                      style: AppStyling.normal500Size16.copyWith(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserSection extends StatelessWidget {
  final UserModel? user;

  const _UserSection({this.user});

  @override
  Widget build(BuildContext context) {
    final name = user?.name ?? 'Guest';
    final email = user?.email ?? '';
    final initials = name.isNotEmpty
        ? name.trim().split(' ').map((w) => w[0].toUpperCase()).take(2).join()
        : 'G';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          // Avatar with initials
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: AppStyling.heading700Size24.copyWith(
                fontSize: 18,
                color: AppColors.surfaceLight,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Name + email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppStyling.normal500Size16.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (email.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    email,
                    style: AppStyling.normal500Size16.copyWith(
                      fontSize: 13,
                      color: AppColors.grey500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  const _DrawerItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ??
        (isActive ? AppColors.primary : AppColors.textPrimary);
    final textColor = labelColor ??
        (isActive ? AppColors.primary : AppColors.textPrimary);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryVeryLight : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                isActive ? activeIcon : icon,
                size: 22,
                color: color,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: AppStyling.normal500Size16.copyWith(
                  color: textColor,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
