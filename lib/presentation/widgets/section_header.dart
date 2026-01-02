import 'package:flutter/material.dart';
import 'package:news/core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Color? iconColor;

  const SectionHeader({
    Key? key,
    required this.icon,
    required this.title,
    this.actionText,
    this.onActionTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: iconColor != null ? null : AppTheme.accentGradient,
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          if (actionText != null)
            TextButton.icon(
              onPressed: onActionTap,
              icon: Text(
                actionText!,
                style: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              label: const Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: AppTheme.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}
