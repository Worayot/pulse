import 'package:flutter/material.dart';

class TextButtonWithDivider extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color textColor; // Add this parameter
  final Color dividerColor;
  final double dividerThickness;
  final double dividerHeight;
  final bool isPressed;
  final VoidCallback onPressed;
  final double paddingAboveDivider;

  const TextButtonWithDivider({
    super.key,
    required this.text,
    this.textStyle,
    this.textColor = Colors.black, // Default text color
    this.dividerColor = Colors.black,
    this.dividerThickness = 1.0,
    this.dividerHeight = 1.0,
    required this.isPressed,
    required this.onPressed,
    required this.paddingAboveDivider,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get the screen size

    // Define responsive font size
    final double fontSize = size.width * 0.05; // 5% of screen width

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: textStyle?.copyWith(color: textColor) ?? // Use textColor
                    TextStyle(
                      fontSize: fontSize, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: textColor, // Use textColor
                    ),
              ),
            ),
            if (isPressed)
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              top: paddingAboveDivider), // Responsive padding above the divider
          child: Divider(
            color: dividerColor,
            thickness: dividerThickness,
            height: dividerHeight,
          ),
        ),
      ],
    );
  }
}
