import 'package:flutter/material.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';
import 'package:flutter_project_architecture/data/models/user_model.dart';

class ModernRoleSelector extends StatelessWidget {
  final UserRole selectedRole;
  final ValueChanged<UserRole> onRoleChanged;

  const ModernRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isReseller = selectedRole == UserRole.reseller;

    return Container(
      height: 56,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: AppColors.border.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Animated Background Indicator
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isReseller
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Interactive Buttons
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onRoleChanged(UserRole.reseller),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.storefront_rounded,
                          size: 20,
                          color: isReseller
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Reseller',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isReseller
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onRoleChanged(UserRole.admin),
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 20,
                          color: !isReseller
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: !isReseller
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
