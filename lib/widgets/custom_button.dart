import 'package:flutter/material.dart';
import 'package:flutter_project_architecture/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;
  final Color? color;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(14.0);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: filled ? null : AppColors.surface,
            gradient: filled
                ? LinearGradient(
                    colors: [
                      color ?? AppColors.primary,
                      (color ?? AppColors.primary).withValues(alpha: 230),
                    ],
                  )
                : null,
            borderRadius: borderRadius,
            boxShadow: filled
                ? [
                    const BoxShadow(
                      color: Color(0x11000000),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
