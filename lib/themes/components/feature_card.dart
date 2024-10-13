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
    // Define fixed width and height for the card
    double cardWidth = size.width * 0.35; // Adjust width as needed
    double cardHeight = size.height * 0.26; // Adjust height as needed

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
          // Align(
          //   alignment: Alignment.center,
          //   child: Text(
          //     title,
          //     style: GoogleFonts.inter(
          //       fontSize: size.width * 0.047,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: double.infinity,
          //   height: size.height * 0.07, // Example height, set as needed
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         title,
          //         textAlign: TextAlign.center,
          //         style: GoogleFonts.inter(
          //           fontSize: size.width * 0.047,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(height: size.height * 0.005),
          Expanded(
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: size.width * 0.04,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis, // Handle overflow if necessary
              maxLines: 4, // Limit subtitle to 2 lines
            ),
          ),
        ],
      ),
    );
  }
}
