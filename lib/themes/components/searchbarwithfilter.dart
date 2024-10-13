import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilteringSearchBar extends StatelessWidget {
  final Size size;
  final ValueChanged<String> onSearchChanged;

  const FilteringSearchBar(
      {super.key, required this.size, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.02),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.05),
        border: Border.all(
          color: const Color(0xff838383), // Border color
          width: 2.4, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color.fromARGB(255, 128, 127, 127)),
          SizedBox(width: size.width * 0.02),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: S.of(context)!.search + '...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
