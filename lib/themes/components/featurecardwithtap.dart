// lib/widgets/feature_card_with_tap.dart
import 'package:flutter/material.dart';
import 'feature_card.dart'; // Ensure this is the correct import

class FeatureCardWithTap extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Size size;

  const FeatureCardWithTap({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.3,
        width: size.width * 0.36,
        child: FeatureCard(
          title: title,
          subtitle: subtitle,
          icon: icon,
          size: size,
        ),
      ),
    );
  }
}
