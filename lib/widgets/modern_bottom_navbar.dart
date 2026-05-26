import 'package:flutter/material.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';

class ModernBottomNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<ModernBottomNavbarItem> items;

  const ModernBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(items.length, (index) {
          final isSelected = index == currentIndex;
          final item = items[index];

          return GestureDetector(
            onTap: () => onTap(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? item.activeIcon : item.icon,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                    size: 24,
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeInOut,
                    child: isSelected
                        ? Row(
                            children: [
                              const SizedBox(width: 6),
                              Text(
                                item.label,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ModernBottomNavbarItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const ModernBottomNavbarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
