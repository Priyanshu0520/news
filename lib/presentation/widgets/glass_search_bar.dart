import 'package:flutter/material.dart';
import 'package:news/core/theme/app_theme.dart';
import 'dart:ui';

class GlassSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool showClearButton;

  const GlassSearchBar({
    Key? key,
    required this.controller,
    this.onSubmitted,
    this.onClear,
    this.showClearButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.25),
                Colors.white.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(-5, -5),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            style: const TextStyle(
              fontSize: 15,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: "Search breaking news...",
              hintStyle: TextStyle(
                color: AppTheme.textSecondary.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: const _SearchIcon(),
              suffixIcon: showClearButton
                  ? _ClearButton(onTap: onClear)
                  : const _MicButton(),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF00D4FF),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.search_rounded,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _ClearButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: const Icon(
        Icons.clear_rounded,
        color: AppTheme.textSecondary,
        size: 22,
      ),
    );
  }
}

class _MicButton extends StatelessWidget {
  const _MicButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFF093FB).withOpacity(0.3),
              const Color(0xFFF5576C).withOpacity(0.3),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFF093FB).withOpacity(0.4),
            width: 1,
          ),
        ),
        child: const Icon(
          Icons.mic_rounded,
          color: Color(0xFFF093FB),
          size: 18,
        ),
      ),
    );
  }
}
