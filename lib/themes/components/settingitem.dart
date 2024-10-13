import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListTile(
      leading: Icon(icon, color: Colors.black, size: size.width * 0.09),
      title: Text(
        title,
        style: GoogleFonts.inter(
          textStyle: TextStyle(fontSize: size.width * 0.045),
        ),
      ),
      trailing: FaIcon(FontAwesomeIcons.circleArrowRight,
          color: Colors.black, size: size.width * 0.065),
      onTap: onTap,
    );
  }
}
