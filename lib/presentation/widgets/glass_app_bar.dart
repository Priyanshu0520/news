import 'package:flutter/material.dart';
import 'dart:ui';

class GlassAppBar extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback? onProfileTap;

  const GlassAppBar({
    Key? key,
    required this.isScrolled,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF667EEA).withOpacity(0.9),
                const Color(0xFF764BA2).withOpacity(0.85),
                const Color(0xFFF093FB).withOpacity(0.8),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667EEA).withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: isScrolled ? 0 : 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _TitleSection(isScrolled: isScrolled),
                  ),
                  _ProfileAvatar(onTap: onProfileTap, isScrolled: isScrolled),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final bool isScrolled;

  const _TitleSection({required this.isScrolled});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isScrolled)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: const Text(
              'Welcome Back! 👋',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (!isScrolled) const SizedBox(height: 8),
        Text(
          'ताज़ा ख़बर',
          style: TextStyle(
            fontSize: isScrolled ? 20 : 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: isScrolled ? 0.5 : 1,
            shadows: [
              Shadow(
                blurRadius: 15,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isScrolled;

  const _ProfileAvatar({this.onTap, required this.isScrolled});

  @override
  Widget build(BuildContext context) {
    final double avatarSize = isScrolled ? 36 : 48;
    final double iconSize = isScrolled ? 20 : 28;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: avatarSize,
        height: avatarSize,
        padding: EdgeInsets.all(isScrolled ? 2 : 3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: isScrolled ? 6 : 12,
              offset: Offset(0, isScrolled ? 3 : 6),
            ),
            if (!isScrolled)
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(-2, -2),
              ),
          ],
        ),
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: isScrolled ? 1 : 2,
                ),
              ),
              child: CircleAvatar(
                radius: (avatarSize - (isScrolled ? 6 : 10)) / 2,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
