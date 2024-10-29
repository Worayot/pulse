// lib/widgets/feature_card.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Size size;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    double cardWidth = size.width * 0.35;
    double cardHeight = size.height * 0.26;

    return Container(
      width: cardWidth,
      height: cardHeight,
      padding: EdgeInsets.all(size.width * 0.05),
      decoration: BoxDecoration(
        color: const Color(0xffBA90CB),
        borderRadius: BorderRadius.circular(size.width * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: size.width * 0.115,
            color: const Color.fromARGB(255, 230, 180, 202),
          ),
          SizedBox(height: size.height * 0.01),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.clip, // Handle overflow if necessary
              maxLines: 2, // Limit subtitle to 2 lines
            ),
          ),
          SizedBox(height: size.height * 0.005),
          SizedBox(
            width: size.width * 0.25,
            child: Expanded(
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: size.width * 0.035,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2, // Limit subtitle to 2 lines
              ),
            ),
          )
        ],
      ),
    );
  }
}
