import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Pulse/themes/color.dart';

class MyButton extends StatefulWidget {
  final String text;
  final void Function()? onTap;

  const MyButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: secondaryColor),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: GoogleFonts.cabin(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            // decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
